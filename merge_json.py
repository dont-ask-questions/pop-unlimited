import json

# Load the main JSON file (defaultAppearances)
with open("defaultAppearances.json", "r", encoding="utf-8") as file:
    main_data = json.load(file)

# Load other JSON files
with open("hair.json", "r", encoding="utf-8") as file:
    hair_data = json.load(file)

with open("mouths.json", "r", encoding="utf-8") as file:
    mouths_data = json.load(file)

with open("shirts.json", "r", encoding="utf-8") as file:
    shirts_data = json.load(file)

with open("pants.json", "r", encoding="utf-8") as file:
    pants_data = json.load(file)

# Function to map attribute numbers to URLs
def map_attributes(attribute_list, lookup_dict):
    return [lookup_dict[str(item)]["url"] for item in attribute_list if str(item) in lookup_dict]

# Merge data
for gender in main_data["defaultAppearances"]:
    main_data["defaultAppearances"][gender]["hair"] = map_attributes(
        main_data["defaultAppearances"][gender]["hair"], hair_data["signup"]
    )
    main_data["defaultAppearances"][gender]["mouths"] = map_attributes(
        main_data["defaultAppearances"][gender]["mouths"], mouths_data["signup"]
    )
    main_data["defaultAppearances"][gender]["shirts"] = map_attributes(
        main_data["defaultAppearances"][gender]["shirts"], shirts_data["signup"]
    )
    main_data["defaultAppearances"][gender]["pants"] = map_attributes(
        main_data["defaultAppearances"][gender]["pants"], pants_data["signup"]
    )

# Save merged JSON
with open("merged_data.json", "w", encoding="utf-8") as file:
    json.dump(main_data, file, indent=4)

print("Merged JSON successfully created: merged_data.json")