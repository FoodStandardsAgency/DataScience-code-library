from json import dump

filename = "secrets/secrets.json"

with open(filename, "w") as f:
    dump(
        {
            "service1": {"key1": "value1", "key2": "value2"},
            "service2": {"key1": "value1", "key2": "value2"},
        },
        f,
    )