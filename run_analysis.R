############################################################################
#                                                                          #          
#           Preparation                                                    #                                   #
#                                                                          #
############################################################################

# Required packages for the analysis
require(reshape)
require(reshape2)

# Setting working directory - Insert your working directory here,
# if you have downloaded the dataset
wd.home <- "C:/Users/Truti/Documents/Boldi/R/DataClean/UCI HAR Dataset"

setwd(wd.home)

############################################################################
#                                                                          #          
#           Getting column names and activity labels                       #                                   #
#                                                                          #
############################################################################

features  <- read.table("features.txt")
col.names <- as.character(features[,2])

activity.labs           <- read.table("activity_labels.txt")
colnames(activity.labs) <- c("id","act.name")


############################################################################
#                                                                          #
#           Getting train data                                             #
#                                                                          #
############################################################################

setwd(paste(wd.home,"/train",sep=""))

train.x       <- read.table("X_train.txt")
train.y       <- read.table("y_train.txt")
train.subject <- read.table("subject_train.txt")

train.data           <- cbind(train.y,train.subject,train.x)
colnames(train.data) <- c("activity.lab","subject.id",col.names)

# Removing further not used variables
rm(train.x); rm(train.y); rm(train.subject); rm(features)

# Removing measurements other than the mean or st.deviation
cols.to.keep    <- c(1:2,grep("mean|std", colnames(train.data)))

# Removing "meanFreq", as its just used at frequency domained data
cols.to.keep    <- cols.to.keep[!cols.to.keep %in% 
                                  grep("Freq", colnames(train.data))]
train.data      <- train.data[,cols.to.keep]
train.data$type <- "train"


############################################################################
#                                                                          #
#           Getting test data                                              #
#                                                                          #
############################################################################

setwd(paste(wd.home,"/test",sep=""))

test.x       <- read.table("X_test.txt")
test.y       <- read.table("y_test.txt")
test.subject <- read.table("subject_test.txt")

test.data           <- cbind(test.y,test.subject,test.x)
colnames(test.data) <- c("activity.lab","subject.id",col.names)

# Removing further not used variables
rm(test.x); rm(test.y); rm(test.subject)

# Removing measurements other than the mean or st.deviation
cols.to.keep   <- c(1:2,grep("mean|std", colnames(test.data)))

# Removing "meanFreq", as its just used at frequency domained data
cols.to.keep    <- cols.to.keep[!cols.to.keep %in% 
                                  grep("Freq", colnames(test.data))]
test.data      <- test.data[,cols.to.keep]
test.data$type <- "test"
rm(cols.to.keep); rm(col.names)


############################################################################
#                                                                          #
#           Merging datasets                                               #
#                                                                          #
############################################################################

# Checking if the columnames or order differ, if all TRUE then not
colnames(test.data) == colnames(train.data)

# Merging
data      <- rbind(train.data,test.data)

# Indicating wether it was assigned to train or test data
data$type <- factor(data$type,levels=c("train","test"))

# Removing unnecessary objects
rm(test.data); rm(train.data)


############################################################################
#                                                                          #
#           Adding descriptive activity names                              #
#                                                                          #
############################################################################

data              <- merge(activity.labs,data,
                           by.y="activity.lab",
                           by.x="id",all.x=T)
data$activity.lab <- NULL
data$id           <- NULL
data              <- rename(data,c(act.name="activity.label"))
data              <- data[,c("type",colnames(data)[-length(colnames(data))])]


############################################################################
#                                                                          #
#           Adding descriptive variable names                              #
#                                                                          #
############################################################################

# Extracting messy variable names
names.to.change <- colnames(data)[4:length(colnames(data))]

# Indicating the different measuring 
# (time for time domain, freq for frequency domain)
names.to.change <- gsub("^t", "time.", names.to.change)
names.to.change <- gsub("^f", "freq.", names.to.change)

# Getting rid of unnecessary "()", and changing "-" to "."
names.to.change <- gsub("\\()", "", names.to.change)
names.to.change <- gsub("-", ".", names.to.change)

# Converting every names to lowercase
names.to.change <- tolower(names.to.change)

colnames(data)[4:length(colnames(data))] <- names.to.change
rm(names.to.change)

############################################################################
#                                                                          #
#           Aggregation                                                    #
#                                                                          #
############################################################################

# Aggregated data
agg.data <- melt(data,id.vars=1:3,measure.vars=4:ncol(data))
agg.data <- dcast(agg.data,
                  subject.id + activity.label + type ~ variable, mean)

# Exporting tidy dataset
tidy.data <- agg.data

setwd(wd.home)
write.table(agg.data,file="tidy.data.txt",row.name=F)
