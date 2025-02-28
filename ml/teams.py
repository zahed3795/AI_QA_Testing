import pandas as pd
import numpy as np
from sklearn import svm
# Visual your data
import matplotlib.pyplot as plt
import seaborn as sns; sns.set(font_scale=1.2)
import pandas as pd
#%matplotlab inline
teams = pd.read_csv("teams.csv")
teams
teams = teams[["team", "country", "year", "athletes", "age", "prev_medals", "medals"]]
teams = teams[["team", "country", "year", "athletes", "age", "prev_medals", "medals"]]
teams.corr()["medals"]
import seaborn as sns
sns.lmplot(x='athletes',y='medals',data=teams,fit_reg=True, ci=None)
sns.lmplot(x='age', y='medals', data=teams, fit_reg=True, ci=None)
teams.plot.hist(y="medals")
teams[teams.isnull().any(axis=1)].head(20)
teams = teams.dropna()

teams.shape
train = teams[teams["year"] < 2012].copy()
test = teams[teams["year"] >= 2012].copy()
# About 80% of the data
train.shape
# About 20% of the data
test.shape
from sklearn.linear_model import LinearRegression

reg = LinearRegression()
predictors = ["athletes", "prev_medals"]
reg.fit(train[predictors], train["medals"])
predictions = reg.predict(test[predictors])
predictions.shape
test["predictions"] = predictions
test.loc[test["predictions"] < 0, "predictions"] = 0
test["predictions"] = test["predictions"].round()
from sklearn.metrics import mean_absolute_error

error = mean_absolute_error(test["medals"], test["predictions"])
error
teams.describe()["medals"]
test["predictions"] = predictions
test[test["team"] == "USA"]
test[test["team"] == "IND"]
errors = (test["medals"] - predictions).abs()
error_by_team = errors.groupby(test["team"]).mean()
medals_by_team = test["medals"].groupby(test["team"]).mean()
error_ratio =  error_by_team / medals_by_team
import numpy as np
error_ratio = error_ratio[np.isfinite(error_ratio)]
error_ratio.sort_values()






