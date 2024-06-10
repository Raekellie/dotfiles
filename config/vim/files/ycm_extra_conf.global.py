def Settings(**kwargs):
    if kwargs["language"] == "rust":
        settings = {"ls": {"checkOnSave": {"command": "clippy"}}}
        return settings
