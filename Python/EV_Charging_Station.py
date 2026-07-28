import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("EV_Charging_Station.csv")

print(df.head())
print(df.tail())
print(df.shape)
print(df.columns)
print(df.info())
print(df.isnull().sum())
print(df.duplicated().sum())


print("Total Charging Sessions:",len(df))

total_revenue = df["Cost_INR"].sum()
print("Total Revenue:",round(total_revenue,2))

total_energy = df["Energy_Consumed_kWh"].sum()
print("Total Energy Consumed:",round(total_energy,2),"kWh")

avg_cost = df["Cost_INR"].mean()
print("Average Charging Cost:",round(avg_cost,2))

avg_energy = df["Energy_Consumed_kWh"].mean()
print("Average Energy Per Session:",round(avg_energy,2),"kWh")


revenue_by_city = (df.groupby("City")["Cost_INR"].sum().sort_values(ascending=False))
print("\nRevenue by City")
print(revenue_by_city)

vehicle_sessions = (df["Vehicle_Type"].value_counts())
print("\nCharging Sessions by Vehicle Type")
print(vehicle_sessions)

payment_revenue = (df.groupby("Payment_Method")["Cost_INR"].sum().sort_values(ascending=False))
print("\nRevenue by Payment Method")
print(payment_revenue)

energy_city = (df.groupby("City")["Energy_Consumed_kWh"].sum().sort_values(ascending=False))
print("\nEnergy Consumed by City")
print(energy_city)


plt.figure(figsize=(8,5))
revenue_by_city.plot(kind='bar')
plt.title("Revenue by City")
plt.xlabel("City")
plt.ylabel("Revenue")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("Revenue_by_City.png")
plt.show()

plt.figure(figsize=(6,5))
vehicle_sessions.plot(kind='bar')
plt.title("Charging Sessions by Vehicle Type")
plt.xlabel("Vehicle Type")
plt.ylabel("Charging Sessions")
plt.tight_layout()
plt.savefig("Vehicle_Type_Sessions.png")
plt.show()

plt.figure(figsize=(6,6))
payment_revenue.plot(kind='pie', autopct="%1.1f%%")
plt.title("Revenue by Payment Method")
plt.ylabel("")
plt.tight_layout()
plt.savefig("Payment_Method_Revenue.png")
plt.show()

plt.figure(figsize=(8,5))
energy_city.plot(kind='bar')
plt.title("Energy Consumed by City")
plt.xlabel("City")
plt.ylabel("Energy (kWh)")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("Energy_by_City.png")
plt.show()