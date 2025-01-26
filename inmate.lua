local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- List of items to check for
local itemsToCheck = {"Glock", "KeyCard", "MP5", "Non-Lethal-Shotgun", "M4A1"}

-- Function to check if the player has any of the specified items
local function hasItem(player)
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, itemName in pairs(itemsToCheck) do
            if backpack:FindFirstChild(itemName) then
                return true  -- Player has the item
            end
        end
    end
    return false  -- Player does not have any of the items
end

-- Function to create/update the text label above the player’s head
local function updateTextLabel(player)
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    -- Check if the player is valid and has a HumanoidRootPart
    if character and humanoidRootPart then
        -- Create the BillboardGui if it doesn't exist yet
        local billboardGui = character:FindFirstChild("BillboardGui")
        if not billboardGui then
            billboardGui = Instance.new("BillboardGui")
            billboardGui.Adornee = humanoidRootPart
            billboardGui.Size = UDim2.new(0, 100, 0, 50)
            billboardGui.StudsOffset = Vector3.new(0, 5, 0)
            billboardGui.Parent = character
        end
        
        -- Create or update the TextLabel inside the BillboardGui
        local textLabel = billboardGui:FindFirstChild("TextLabel")
        if not textLabel then
            textLabel = Instance.new("TextLabel")
            textLabel.Name = "TextLabel"
            textLabel.TextSize = 18
            textLabel.BackgroundTransparency = 1
            textLabel.TextStrokeTransparency = 0.8
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.Parent = billboardGui
        end
        
        -- Update the text based on whether the player has the specified items
        if hasItem(player) then
            textLabel.Text = "Inmate"
            textLabel.TextColor3 = Color3.new(1, 0, 0)  -- Red if player has an item
        else
            textLabel.Text = "Inmate"
            textLabel.TextColor3 = Color3.new(0, 1, 0)  -- Green if player does not have an item
        end
    end
end

-- Loop through all players in the game and update their text every 5 seconds
while true do
    for _, player in pairs(Players:GetPlayers()) do
        if player.Team == Teams:FindFirstChild("Inmates") then
            updateTextLabel(player)
        end
    end
    wait(1)  -- Wait for 5 seconds before updating the labels again
end
