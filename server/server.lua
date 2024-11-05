local VORPCore = exports.vorp_core:GetCore()


--Get Current Server Time
VORPCore.Callback.Register('hec-trainnotice:callback:gettime', function(source, cb)
    local _source = source
    local _item = item
	local tm = os.time()
    cb(tm)	
end)



--Give the player their rewards after opening the chest
RegisterServerEvent('hec-trainnotice:checknotice')
AddEventHandler("hec-trainnotice:checknotice", function(tm)
    local _source = source
    local _tm = tm

    local entries = MySQL.query.await("SELECT * FROM train_board WHERE entered > ?", { _tm })

    print(#entries)

    -- Iterate through new train updates
    for i = 1, #entries do
        local _departing = ''
        local _destination = ''
        local _status = ''

        if entries[i].departing ~= null then 
            _departing = entries[i].departing
        end

        if entries[i].destination ~= null then 
            _destination = entries[i].destination
        end

        if entries[i].status ~= null then
            if entries[i].status == 'Stopped' then
                _status = 'At Stop'
            else
                _status = entries[i].status
            end    
        end

        local note = entries[i].service .. ' Train\nDeparting: ~COLOR_YELLOWLIGHT~' .. 
            _departing .. '\n~COLOR_WHITE~Destination: ~COLOR_YELLOWLIGHT~' .. 
            _destination .. '\n~COLOR_WHITE~Status: ~COLOR_YELLOWLIGHT~' .. _status

        VORPCore.NotifyTip(_source, note ,6000)
    end
end)