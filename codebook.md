## Codebook

subject.id - Identifies the subject, integer, range: 1 to 30

activity.label - Identifies the activity, categorical variable, 6 levels (LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS)

type - Identifies the type, categorical variable, 2 levels (train, test)

Other variables has a standard structure. They are all numerical variables and they are the mean of variables by subject and activity type of the source data.
It has 4 parts, each separated with a dot. The parts are:
* 1: time or freq, indicates the domain of the measurement,
* 2: indicates the measured variable,
* 3: mean or std, indicates wether is this variable the mean or the standard deviation,
* 4: indicates the measured axis (x,y,z).

### Source:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - UniversitA  degli Studi di Genova, Genoa I-16145, Italy.
activityrecognition '@' smartlab.ws
www.smartlab.ws 