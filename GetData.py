import http.client
import json

conn = http.client.HTTPSConnection("zillow69.p.rapidapi.com")

headers = {
    'X-RapidAPI-Key': "d86e119cc7msh9392a133114049ep142b2ajsn4d3aca3bb451",
    'X-RapidAPI-Host': "zillow69.p.rapidapi.com"
}

conn.request("GET", "/property?property_url=https%3A%2F%2Fwww.zillow.com%2Fhomedetails%2F21-Father-Francis-Gilday-St-APT-107-Boston-MA-02118%2F81771510_zpid%2F", headers=headers)

res = conn.getresponse()
data = res.read()

# convert the above bytes data to json
data = json.loads(data.decode("utf-8"))
# now dump the data to a json file
# open a file for writing
out_file = open("data/data.json", "w")
json.dump(data, out_file, indent = 6)
out_file.close()
print("JSON data is saved to a file")
