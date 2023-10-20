function decodeJsonStrings(table)
    for _, entry in ipairs(table) do
        if entry["ludaro_jobs_info"] then
            local decoded, _, err = json.decode(entry["ludaro_jobs_info"], 1, nil)
            if not err then
                entry["ludaro_jobs_info"] = decoded
            else
                print("Error decoding JSON:", err)
            end
        end
    end
end
