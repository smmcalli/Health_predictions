# Heart_Attack_Predictions

"Banerjee, S. (n.d.). Heart attack risk prediction dataset [Data set]. Kaggle. https://www.kaggle.com/datasets/iamsouravbanerjee/heart-attack-prediction-dataset"

This project was completed using an adjusted version of the dataset above. Because the original data was synthetically generated `Heart.Attack.Risk` was altered to allow for more realistic correlations. This dataset uses health statistics such as age, cholesterol and blood pressure to predict the risk of a heart attack. 

__Project Overview:__
This project aims to determine what factors are most relevant for predicting the risk of a heart attack. A combination of supervised and unsupervised machine learning techniques (including decision trees, random forests, PCA, and K-means clustering) were used to evaluate patterns in patient data and develop models for identifying high-risk individuals. Accurate risk prediction can help healthcare providers prioritize patients more effectively and support timely clinical decision-making in environments with limited resources.


__Questions This Project Seeks to Answer:__
- What attributes are most useful in predicting a patient's heart attack risk?

__Methods:__

Data Cleaning:
- Parsed Blood Pressure to SystolicBP and DiastolicBP
- converted data types when necessary 

Analysis:
- Decision Trees
- Random Forests
- Principal Component Analsis
- K-means

__Demonstrated Experience:__
- R


__Key Findings:__
- The variable importance plot generated from the random forest shows that the top three attributes for predicting heart attack risk are Cholesterol, Age, and SystolicBP.
