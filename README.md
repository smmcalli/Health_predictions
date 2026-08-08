# Heart_Attack_Predictions

"Banerjee, S. (n.d.). Heart attack risk prediction dataset [Data set]. Kaggle. https://www.kaggle.com/datasets/iamsouravbanerjee/heart-attack-prediction-dataset"

This project was completed using an adjusted version of the dataset above. Because the original data was synthetically generated `Heart.Attack.Risk` was altered to allow for more realistic correlations. This dataset uses health statistics such as age, cholesterol and blood pressure to predict the risk of a heart attack. 

__Project Overview:__

This project aims to determine what factors are most relevant for predicting the risk of a heart attack. A combination of supervised and unsupervised machine learning techniques (including decision trees, random forests, PCA, and K-means clustering) were used to evaluate patterns in patient data and develop models for identifying high-risk individuals. Accurate risk prediction can help healthcare providers prioritize patients more effectively and support timely clinical decision-making in environments with limited resources.


__Questions This Project Seeks to Answer:__

- What attributes are most useful in predicting a patient's heart attack risk?
- Is it possible to accurately evaluate risk using predictive modeling techniques?

__Methods:__

Data Cleaning:
- Parsed Blood Pressure to SystolicBP and DiastolicBP
- converted data types when necessary 

Analysis:
- Exploratory Data Analysis
- Decision Trees
- Random Forests
- Principal Component Analsis
- K-means
- Model Evaluation and Validation

__Demonstrated Experience:__

- R
- ggplot2
- Supervised Learning
- Unsupervised Learning


__Key Findings:__

- Random Forest analysis was able to predict heart attack risk with a 91% accuracy.
  - The variable importance plot generated from the random forest shows that the top three attributes for predicting heart attack risk are Cholesterol, Age, and SystolicBP.
- PCA was able to show that >50% of variance could be explaned with Principal Components 1-5.
  -   Attributes in Principal Components 1-5 with magnitude >.3:
    -   PC1: strong positive associations for SystolicBP and ratio, strong negative association for DiastolicBP
    -   PC2: strong positive associations for Cholesterol and Exercise, strong negative association for Stress.Level
    -   PC3: strong positive associations for Sleep.Hours.Per.Day, strong negative association for Exercise.Hours.Per.Week and Triglycerides
    -   PC4: strong positive associations for BMI, SystolicBP, and DiastolicBP
    -   PC5: strong negative association for Cholesterol, Exercise.Hours.Per.Week, Stress.Level, and Physical.Activity.Days.Per.Week
-  K-means analysis using Principal Components 1-5 generated an adjusted random index of .66 indicating substantial agreement between the unsupervised clusters and the risk labels.
  -  This suggests that the risk classifications are supported by meaningful patterns in the underlying patient health data rather than being randomly assigned.
