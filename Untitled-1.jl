using Pkg 
# Pkg.add("FreqTables")
# Pkg.add("DataFrames")
# Pkg.add("CSV")
using FreqTables
using DataFrames
using CSV

df = DataFrame(CSV.File("./UCS-Satellite-Database-5-1-2022.csv"))

# Who owns the most satellites?

c_o_o=  df[!,:"Country of Operator/Owner"]

sort(freqtable(c_o_o),rev=true)

sort(freqtable(df.Purpose),rev=true)

sort(freqtable(df."Class of Orbit"),rev=true)

sort(freqtable(df."Launch Site"),rev=true)

# which countries have launched from Cape Canaveral?


# select Country of Operator/Owner, Launch Site
df_cap = select(df, [:"Country of Operator/Owner", :"Launch Site"])


# assign the columns to be strings 
df_cap[!, :"Country of Operator/Owner"] = string.(df_cap[!, :"Country of Operator/Owner"])
df_cap[!, :"Launch Site"] = string.(df_cap[!, :"Launch Site"])


df_cap = filter!(row -> occursin("Cape Canaveral", row[2]), df_cap)


sort(freqtable(df_cap[!, :"Country of Operator/Owner"]),rev=true)


# where does turkey launch from?

df_turkey = select(df, [:"Country of Operator/Owner", :"Launch Site"])

df_turkey[!, :"Country of Operator/Owner"] = string.(df_turkey[!, :"Country of Operator/Owner"])
df_turkey[!, :"Launch Site"] = string.(df_turkey[!, :"Launch Site"])


df_turkey = filter!(row -> occursin("Turkey", row[1]), df_turkey)


sort(freqtable(df_turkey[!, :"Launch Site"]),rev=true)

df_why_turkey = select(df, [ 
:"Name of Satellite, Alternate Names",
 :"Current Official Name of Satellite",
 :"Country/Org of UN Registry",
 :"Country of Operator/Owner",
 :"Operator/Owner",
 :"Users",
 :"Purpose",
 :"Detailed Purpose",
 :"Class of Orbit",
 :"Type of Orbit",
:"Date of Launch",
 :"Expected Lifetime (yrs.)",
 :"Contractor",
 :"Country of Contractor",
 :"Launch Site",
 :"Launch Vehicle",
])

# sort by Country of Operator/Owner in Turkey

for i in 1:16
    df_why_turkey[!, i] = string.(df_why_turkey[!, i])
end


df_why_turkey = filter!(row -> occursin("Turkey", row[4]), df_why_turkey)

# filter where the launch site is Jiuquan Satellite Launch Center

df_why_turkey = filter(row -> occursin("Jiuquan Satellite Launch Center", row[15]), df_why_turkey)

# I'll just do it until here. 
