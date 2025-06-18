// Simulated config for AI odds engine (for internal QA use only)
const defaultHeaders = {
    "X-BET-STAFF": "off",
    "X-BETA-EXPERIMENTAL": "enabled"
};

function load() {
    console.log("CoteAI™ headers loaded:", defaultHeaders);

    fetch("/ping", {
        method: "GET",
        headers: {
            "X-BET-STAFF": defaultHeaders["X-BET-STAFF"]
        }
    })
    .then(response => response.json())
    .then(data => console.log("Ping response:", data))
    .catch(err => console.warn("Ping failed"));
}

load();