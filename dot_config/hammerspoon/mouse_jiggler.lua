-- Random mouse movement with continuous direction
local interval = 10 -- seconds between movement sessions
local movementDuration = 2 -- seconds to move the mouse
local speed = 150 -- pixels per step (increased for faster movement)
local stepDelay = 0.005 -- seconds between steps (200 steps/second for smoother movement)
local totalSteps = movementDuration / stepDelay

-- Current angle (will change slightly with each step)
local currentAngle = math.random() * 2 * math.pi

-- Function to move mouse in a direction with random turns
local function randomDirectionalMove()
    local startPos = hs.mouse.absolutePosition()
    local currentPos = { x = startPos.x, y = startPos.y }

    -- Choose a new base direction (but keep some continuity)
    currentAngle = currentAngle + (math.random() - 0.5) * math.pi / 4

    local step = 0
    ---@diagnostic disable-next-line: unused-local
    local moveTimer = hs.timer.doUntil(function()
        return step >= totalSteps
    end, function()
        -- Add slight random turn (-5 to +5 degrees)
        local angleChange = (math.random() - 0.5) * math.pi / 18
        currentAngle = currentAngle + angleChange

        -- Calculate movement
        local dx = math.cos(currentAngle) * speed * stepDelay
        local dy = math.sin(currentAngle) * speed * stepDelay

        -- Move mouse
        currentPos.x = currentPos.x + dx
        currentPos.y = currentPos.y + dy
        hs.mouse.absolutePosition(currentPos)

        step = step + 1

        -- Log completion in one line
        if step >= totalSteps then
            local endPos = hs.mouse.absolutePosition()
            local distance = math.sqrt((endPos.x - startPos.x) ^ 2 + (endPos.y - startPos.y) ^ 2)
            print(
                string.format(
                    "[%s] Mouse moved (%.0f, %.0f) → (%.0f, %.0f), traveled %.0f pixels",
                    os.date("%H:%M:%S"),
                    startPos.x,
                    startPos.y,
                    endPos.x,
                    endPos.y,
                    distance
                )
            )
        end
    end, stepDelay)
end

-- Create the timer but don't start it
MouseTimer = hs.timer.doEvery(interval, randomDirectionalMove)
MouseTimer:stop() -- Stop it immediately so it starts in stopped state

-- Hotkey to toggle on/off
hs.hotkey.bind({ "shift", "alt", "ctrl" }, "M", function()
    if MouseTimer:running() then
        MouseTimer:stop()
        print("[" .. os.date("%H:%M:%S") .. "] 🖱️ STOPPED")
        hs.alert.show("🖱️ STOPPED")
    else
        MouseTimer:start()
        print("[" .. os.date("%H:%M:%S") .. "] 🖱️ STARTED")
        hs.alert.show("🖱️ STARTED")
    end
end)

print("[" .. os.date("%H:%M:%S") .. "] 🖱️ automation loaded (STOPPED)")
hs.alert.show("🖱️ automation loaded (STOPPED)")
