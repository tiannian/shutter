function msoutput(inta)
    
end

function compute(express, x)
    local exp = 'function(x) ' .. express .. 'end'
    return loadstring(exp)(x)
end

function start(speed, time, express)
    local index = 0
    local totol = speed * time
    local interval = 1 / (speed / 60)
    tmr.alarm(3, interval, tmr.ALARM_AUTO, function()
        local inta = compute(express,index)
        msoutput(inta)
        index = index + 1
    end)
end

return function(connection, req, args)
    dofile("httpserver-header.lc")(connection, 200, 'html')
    if req.method == "POST" then
        local data = req.getRequestData()
        start(data['speed'], data['time'], data['express'])
    end
end
