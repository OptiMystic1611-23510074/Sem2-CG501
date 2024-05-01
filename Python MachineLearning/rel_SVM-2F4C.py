import numpy as np
import pandas as pd
from sklearn.svm import SVC
import matplotlib.pyplot as plt
from sklearn.utils import shuffle
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split


# Specify the file path (adjust if needed)
file_path = "Features.xlsx"

# Read the first sheet using pandas.read_excel() with sheet_name=0 (zero-based indexing)
df = pd.read_excel(file_path, sheet_name=4)
df = shuffle(df, random_state=5)
# print(df)


# Creating x array using list comprehension
x = np.array([[float(df.loc[i, 'RelativeTheta']), float(df.loc[i, 'RelativeAlpha'])] for i in df.index])

# Creating y array
y = np.empty(len(df))
for i in range(len(df)):
    if df.loc[i, 'condition']  == 'highMemory':
        y[i] = 2
    elif df.loc[i, 'condition']  == 'lowMemory':
        y[i] = 1
    elif df.loc[i, 'condition'] == 'lowControl':
        y[i] = -1
    elif df.loc[i, 'condition'] == 'highControl':
        y[i] = -2
    else:
        pass


# Standardizing features
x = StandardScaler().fit_transform(x)

# Allocate 25% of the data for testing (test_size=0.25)
x_train, x_test, y_train, y_test = train_test_split(x, y, stratify=y, test_size=0.25, random_state=1)

# Creating the SVM model with RBF kernel
model = SVC(kernel='rbf', C=0.2, gamma=3.0, probability=True)

# Training the model
model.fit(x_train, y_train)

# Calculating Accuracy
accuracy = model.score(x_test, y_test)
print('\nAccuracy: {} %'.format(accuracy * 100))
