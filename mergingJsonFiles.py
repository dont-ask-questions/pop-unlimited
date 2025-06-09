import json

# Load main JSON
with open("defaultAppearances.json", "r") as f:
    main_data = json.load(f)

# Load mapping files
mapping_files = {
    "attribute1": "map1.json",
    "attribute2": "map2.json",
    "attribute3": "map3.json",
    "attribute4": "map4.json"
}

merged_data = {}

# Process each attribute
for attribute, map_file in mapping_files.items():
    with open(map_file, "r") as f:
        url_map = json.load(f)["url_map"]

    # Convert numbers to URLs
    merged_data[attribute] = [
        {"number": num, "urls": url_map.get(str(num), [])}
        for num in main_data[attribute]
    ]

# Save the new JSON
with open("merged.json", "w") as f:
    json.dump(merged_data, f, indent=4)

print("Merged JSON file saved as merged.json")