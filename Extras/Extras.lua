--Multiple Game Support: -- lets you run a script on several different games on one loadstring
if game.PlaceId == GameIdHere then
   --script or loadstring here
   end

--Anti-AFK:
wait(3)
local VirtualUser=game:service'VirtualUser'
game:service('Players').LocalPlayer.Idled:connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)

--Fly:
local FlyingKey = Enum.KeyCode.B

flyspeed = 3

--Ignore everything below. This is the primary code.
Players = game:GetService("Players")
Mouse = Players.LocalPlayer:GetMouse()

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

function sFLY()
	repeat wait() until Players.LocalPlayer and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	repeat wait() until Mouse
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

	local T = getRoot(Players.LocalPlayer.Character)
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0

	local function FLY()
		
		
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat wait()
				if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
					Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
			until not _G.WRDFLY
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
				Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end
	flyKeyDown = Mouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = flyspeed
		elseif KEY:lower() == 's' then
			CONTROL.B = - flyspeed
		elseif KEY:lower() == 'a' then
			CONTROL.L = - flyspeed
		elseif KEY:lower() == 'd' then 
			CONTROL.R = flyspeed
		elseif KEY:lower() == 'e' then
			CONTROL.Q = flyspeed*2
		elseif KEY:lower() == 'q' then
			CONTROL.E = -flyspeed*2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
	flyKeyUp = Mouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'e' then
			CONTROL.Q = 0
		elseif KEY:lower() == 'q' then
			CONTROL.E = 0
		end
	end)
	FLY()
end

function NOFLY()
	
	
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
		Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

--Reinjection toggle
_G.WRDFLY = not _G.WRDFLY
if(_G.WRDFLY) then
	sFLY()
else
	NOFLY()
end

--Vehicle Fly:
local FlyKey = Enum.KeyCode.V
        local SpeedKey = Enum.KeyCode.LeftControl
        
        local SpeedKeyMultiplier = 3
        local FlightSpeed = 256
        local FlightAcceleration = 4
        local TurnSpeed = 16
        
        -- made by zach
        
        -- enjoy :3
        
        local UserInputService = game:GetService("UserInputService")
        local StarterGui = game:GetService("StarterGui")
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local User = Players.LocalPlayer
        local Camera = workspace.CurrentCamera
        local UserCharacter = nil
        local UserRootPart = nil
        local Connection = nil
        
        
        workspace.Changed:Connect(function()
            Camera = workspace.CurrentCamera
        end)
        
        local setCharacter = function(c)
            UserCharacter = c
            UserRootPart = c:WaitForChild("HumanoidRootPart")
        end
        
        User.CharacterAdded:Connect(setCharacter)
        if User.Character then
            setCharacter(User.Character)
        end
        
        local CurrentVelocity = Vector3.new(0,0,0)
        local Flight = function(delta)
            local BaseVelocity = Vector3.new(0,0,0)
            if not UserInputService:GetFocusedTextBox() then
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    BaseVelocity = BaseVelocity + (Camera.CFrame.LookVector * FlightSpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    BaseVelocity = BaseVelocity - (Camera.CFrame.RightVector * FlightSpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    BaseVelocity = BaseVelocity - (Camera.CFrame.LookVector * FlightSpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    BaseVelocity = BaseVelocity + (Camera.CFrame.RightVector * FlightSpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    BaseVelocity = BaseVelocity + (Camera.CFrame.UpVector * FlightSpeed)
                end
                if UserInputService:IsKeyDown(SpeedKey) then
                    BaseVelocity = BaseVelocity * SpeedKeyMultiplier
                end
            end
            if UserRootPart then
                local car = UserRootPart:GetRootPart()
                if car.Anchored then return end
                if not isnetworkowner(car) then return end
                CurrentVelocity = CurrentVelocity:Lerp(
                    BaseVelocity,
                    math.clamp(delta * FlightAcceleration, 0, 1)
                )
                car.Velocity = CurrentVelocity + Vector3.new(0,2,0)
                if car ~= UserRootPart then
                    car.RotVelocity = Vector3.new(0,0,0)
                    car.CFrame = car.CFrame:Lerp(CFrame.lookAt(
                        car.Position,
                        car.Position + CurrentVelocity + Camera.CFrame.LookVector
                    ), math.clamp(delta * TurnSpeed, 0, 1))
                end
            end
        end
        
        UserInputService.InputBegan:Connect(function(userInput,gameProcessed)
            if gameProcessed then return end
            if userInput.KeyCode == FlyKey then
                if Connection then
                    StarterGui:SetCore("SendNotification",{
                        Title = "zachs car fly",
                        Text = "Flight disabled"
                    })
                    Connection:Disconnect()
                    Connection = nil
                else
                    StarterGui:SetCore("SendNotification",{
                        Title = "zachs car fly",
                        Text = "Flight enabled"
                    })
                    CurrentVelocity = UserRootPart.Velocity
                    Connection = RunService.Heartbeat:Connect(Flight)
                end
            end
        end)
        
        StarterGui:SetCore("SendNotification",{
            Title = "zachs car fly",
            Text = "Loaded successfully, Press V to toggle"
        })

--Chat Logger:
-- Chat Logger Made by ZACH.#6257
if game:service('RunService'):IsStudio() then print('!STUDIO!') else
	if game:service('CoreGui'):findFirstChild('LogHolder') then return nil
	end
end

local LogHolder = Instance.new("ScreenGui")
local Logs = Instance.new("Frame")
local Scroll = Instance.new("ScrollingFrame")
local Template = Instance.new("TextLabel")

LogHolder.Name = "LogHolder"
if game:service('RunService'):IsStudio() then LogHolder.Parent = game.Players.LocalPlayer.PlayerGui else
	LogHolder.Parent = game.CoreGui
end

Logs.Name = "Logs"
Logs.Parent = LogHolder
Logs.AnchorPoint = Vector2.new(0.5, 0.5)
Logs.BackgroundColor3 = Color3.new(0, 0, 0)
Logs.Position = UDim2.new(0.200000003, 0, 0.200000003, 0)
Logs.Size = UDim2.new(0, 400, 0, 250)
Logs.Style = Enum.FrameStyle.DropShadow

Scroll.Name = "Scroll"
Scroll.Parent = Logs
Scroll.BackgroundColor3 = Color3.new(0, 0, 0)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.Size = UDim2.new(1, 0, 1, 0)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.ScrollBarThickness = 6

Template.Name = "Template"
Template.Parent = Logs
Template.BackgroundColor3 = Color3.new(1, 1, 1)
Template.BackgroundTransparency = 1
Template.Position = UDim2.new(0, 0, 0, -25)
Template.Size = UDim2.new(1, 0, 0, 20)
Template.Font = Enum.Font.ArialBold
Template.Text = ""
Template.TextColor3 = Color3.new(1, 1, 1)
Template.TextSize = 15
Template.TextXAlignment = Enum.TextXAlignment.Left
Template.TextWrap = true

Logs.Active = true
Logs.Draggable = true

local loggedTable = {}

local getTotalSize = function()
local totalSize = UDim2.new(0, 0, 0, 0)
	
	for i, v in next, loggedTable do
		totalSize = totalSize + UDim2.new(0, 0, 0, v.Size.Y.Offset)
	end
	
	return totalSize
end

local BUD = UDim2.new(0, 0, 0, 0)
local TotalNum = 0

local function GenLog(txt, colo, time)
	local oldColo = Color3.fromRGB(0, 0, 0)	
	
	local Temp = Template:Clone()
	Temp.Parent = Scroll
	Temp.Name = txt..'Logged'
	Temp.Text = tostring(txt)
	Temp.Visible = true
	Temp.Position = BUD + UDim2.new(0, 0, 0, 0)
	if colo then oldColo = colo Temp.TextColor3 = colo elseif not colo then Temp.TextColor3 = Color3.fromRGB(200, 200, 200) end

	local timeVal = Instance.new('StringValue', Temp)
	timeVal.Name = 'TimeVal'
	timeVal.Value = time

	TotalNum = TotalNum + 1
	
	if not Temp.TextFits then repeat Temp.Size = UDim2.new(Temp.Size.X.Scale, Temp.Size.X.Offset, Temp.Size.Y.Scale, Temp.Size.Y.Offset + 10)
		Temp.Text = txt
	until Temp.TextFits 
end

	BUD = BUD + UDim2.new(0, 0, 0, Temp.Size.Y.Offset)
	
	table.insert(loggedTable, Temp)
	
	local totSize = getTotalSize()
	
	if totSize.Y.Offset >= Scroll.CanvasSize.Y.Offset then Scroll.CanvasSize = UDim2.new(totSize.X.Scale, totSize.X.Offset, totSize.Y.Scale, totSize.Y.Offset + 100)
	Scroll.CanvasPosition = Scroll.CanvasPosition + Vector2.new(0, totSize.Y.Offset) 
	end
	
	return Temp
end

local ChatData = ""

local function SaveToFile()
	local t = os.date("*t")
	local dateDat = t['hour']..' '..t['min']..' '..t['sec']..' '..t['day']..'.'..t['month']..'.'..t['year']
	
	ChatData = ""
	
	for i, v in pairs(Scroll:GetChildren()) do
		ChatData = ChatData..v.TimeVal.Value..' '..v.Text..'\n'
	end
	
	writefile('ChatLogs '..dateDat..'.txt', ChatData)
end


local function Clear()
	loggedTable = {}
	ChatData = ""
	Scroll.CanvasPosition = Vector2.new(0, 0)
	for i, v in pairs(Scroll:GetChildren()) do
		v:Destroy()
	end
	Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	BUD = UDim2.new(0, 0, 0, 0)
end

local LogPlr = function(plr)
			plr.Chatted:connect(function(msg)
				
			local t = os.date("*t")
			local dateDat = t['hour']..':'..t['min']..':'..t['sec']
	
			if string.len(msg) >= 1000 then return nil end
			if string.lower(msg) == 'clear' and plr == game:service('Players').LocalPlayer then Clear() return nil end
			if string.lower(msg) == 'savetofile' and plr == game:service('Players').LocalPlayer then SaveToFile() return nil end
			if string.sub(msg, 1, 1):match('%p') and string.sub(msg, 2, 2):match('%a') and string.len(msg) >= 5 then GenLog(plr.Name..': '..msg, Color3.new(255, 0, 0), dateDat) else
			GenLog(plr.Name..': '..msg, Color3.new(255, 255, 255), dateDat)
			end
	end)
end

for i, v in pairs(game.Players:GetChildren()) do
	LogPlr(v)
end

game.Players.PlayerAdded:connect(function(plr)
	LogPlr(plr)
end)

--Basic ESP:
        local esp_settings = { ---- table for esp settings 
        textsize = 10,
        colour = 0,255,255
    }


    
    local gui = Instance.new("BillboardGui")
    local esp = Instance.new("TextLabel",gui) ---- new instances to make the billboard gui and the textlabel
    
    
    
    gui.Name = "Zachs ESP"; ---- properties of the esp
    gui.ResetOnSpawn = false
    gui.AlwaysOnTop = true;
    gui.LightInfluence = 0;
    gui.Size = UDim2.new(2, 0, 2, 0);
    esp.BackgroundColor3 = Color3.fromRGB(0,255,255);
    esp.Text = ""
    esp.Size = UDim2.new(0.0001, 0.00001, 0.0001, 0.00001);
    esp.BorderSizePixel = 4;
    esp.BorderColor3 = Color3.new(esp_settings.colour)
    esp.BorderSizePixel = 0
    esp.Font = "Arial"
    esp.TextSize = esp_settings.textsize
    esp.TextColor3 = Color3.fromRGB(esp_settings.colour) -- text colour
    
    game:GetService("RunService").RenderStepped:Connect(function() ---- loops faster than a while loop :)
        for i,v in pairs (game:GetService("Players"):GetPlayers()) do
            if v ~= game:GetService("Players").LocalPlayer and v.Character.Head:FindFirstChild("Zachs ESP")==nil  then
                esp.Text = "["..v.Name.."]"
                gui:Clone().Parent = v.Character.Head
        end
    end
    end)

--NoClip:
game:GetService('RunService').Stepped:connect(function()
game.Players.LocalPlayer.Character.Head.CanCollide = false
game.Players.LocalPlayer.Character.Torso.CanCollide = false
end)



--Notification:
wait(1) -- in the () is how long u want it to wait before it pups up, in seconds
game.StarterGui:SetCore("SendNotification", {
Title = "this is how"; -- the title (ofc)
Text = "to make a notification"; -- what the text says (ofc)
Icon = "rbxassetid://57254792"; -- change the image id to what u want if u want an image, if not, delete this row.
Duration = 5; -- how long the notification show should in secounds
})
