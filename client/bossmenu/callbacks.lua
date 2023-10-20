function sql_getAllJobInfo()
    return lib.callback.await('ludaro_jobs:getalljobinfo', false)
end
