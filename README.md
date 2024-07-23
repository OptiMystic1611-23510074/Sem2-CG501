# Sem2-CG501
## Computation and Cognition

#### This repository has coursework material that was used for the course project.

<br />

----

In this project, I have used machine learning, specifically Support Vector Machine (SVM), and trained classifiers that identify working memory load states. Building upon the findings of the study by Kosachenko et al. ([2023](https://doi.org/10.1111/psyp.14275)). They have identified the signatures of WM overload. Firstly, they have identified that under load conditions the theta frequency power increases at the fontal midline location. And the alpha frequency power decreases at the posterior location of the brain. I have followed standard steps for preprocessing and cleaning EEG data (using MATLAB/EEGLAB pipelines). Then identified several features that could be extracted from it and extracted one of them (via MATLAB/EEGLAB script). 

After that I have trained SVM classifiers (using Python/Sci-kit learn) to classify memory and non-memory conditions (also high-low memory-non memory conditions). And I have varied values along the range followed by a study by Dimitrakopoulos et al. ([2017](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=7919266)). I have organized the data in three ways; each with two classes (four for last dataset) and two features (six for first dataset). By doing so, I have explored on the effectiveness of machine learning technique, SVM specifically, in handling the physiological data like EEG. I have improved my understanding of working with EEG data. Moreover, I have trained various classification models based on SVM, where the classifiers were able to give accuracy better than just random guess. 

##### RESULTS
**I. Six-Features and Two-Classes – Absolute**

The theta band power at Fz electrode, the alpha band powers at Pz, P1, P2, P3 and P4 electrodes. All these band power values were passed as six features to an SVM classifier class, using a Radial Basis Function (RBF) kernel with C=0.2 and gamma=1.0 for the hinge learning method. The model achieved an accuracy of **45.2%**.

*Code: https://github.com/OptiMystic1611-23510074/Sem2-CG501/blob/main/Python%20MachineLearning/abs_SVM-6F.py*

**II. Two-Features and Two-Classes – Absolute**

Next, I took average of the alpha band electrodes; Pz, P1, P2, P3 and P4 electrodes for all the subjects. This resulted in two features; the theta band power at Fz electrode, the alpha band powers at mean_P band. A same SVM classifier class using a Radial Basis Function (RBF) kernel with C=0.2 and gamma=1.0 for the hinge learning method was used to train the model on this data. The accuracy of the model improved slightly to **48.4%**.

*Code: https://github.com/OptiMystic1611-23510074/Sem2-CG501/blob/main/Python%20MachineLearning/abs_SVM-2F.py*

**III. Two-Features and Two-Classes – Relative**

So far, the band power values are absolute, means values correspond to subjects only are not normalized in some way. Thus, in order to improve the accuracy, I did rest state correction. For this, all the resting state EEG data for each subject was also pre-processed same way as main data as processed and then same features were extracted from it. Once done, the resting state values were subtracted with the absolute values to obtain relative band power values (Figure 8). A similar SVM classifier class using a Radial Basis Function (RBF) kernel with C=0.2 and gamma=2.0 for the hinge learning method was used to train the model on this new data. The accuracy of the model improved to **56.7%**.

*Code: https://github.com/OptiMystic1611-23510074/Sem2-CG501/blob/main/Python%20MachineLearning/rel_SVM-2F.py*

The datasets generated up until this point involve binary classification (2 class classification). For binary classification, guessing randomly has 50% accuracy, this any model doing binary classification and is below 50% of accuracy can be considered as unnecessary.

**IV. Two-Features and Four-Classes – Relative**

Similarly, for a classification among four classes, the model should to the very least should have accuracy of 25% or above. So next I divided the classes into four. Figure 9 shows that there is significant difference in the participant’s theta activity once they are shown more than 5 digits. Likewise, for alpha activity. The difference is more visible after 5 digits are already shown to the participant. 
Therefore, same steps were performed as in II and III along the four classes of high-control (just listen, more than 5 digits), low-control (just listen, 5 and less than 5 digits), low-memory (remember, 5 and less than 5 digits) and high-memory (remember, 5 and less than 5 digits). Figure 10 shows the scatter plot distribution of this four-class data. This data was again passed to SVM classifier of similar configuration. The accuracy for the model was found out to be **33.3%**.

*Code: https://github.com/OptiMystic1611-23510074/Sem2-CG501/blob/main/Python%20MachineLearning/rel_SVM-2F4C.py*

----

<br />

Please note that the dataset used for this project is not owned by me.

**Original Authors:** Yuri G. Pavlov, Dauren Kasanov, Alexandra I. Kosachenko, Alexander I. Kotyusov

**OpenNeuro URL:** https://openneuro.org/datasets/ds003838/versions/1.0.6
