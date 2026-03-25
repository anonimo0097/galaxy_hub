local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local speed = false
local jump = false
local noclip = false
local infjump = false
local fly = false

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,300,0,350)
main.Position = UDim2.new(0.35,0,0.25,0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,30)
title.Text = "🌌 Galaxy Hub V2"
title.BackgroundColor3 = Color3.fromRGB(40,40,40)
title.TextColor3 = Color3.new(1,1,1)

local function button(text,pos,func)
local b = Instance.new("TextButton", main)
b.Size = UDim2.new(0.9,0,0,30)
b.Position = UDim2.new(0.05,0,0,pos)
b.Text = text
b.BackgroundColor3 = Color3.fromRGB(45,45,45)
b.TextColor3 = Color3.new(1,1,1)

b.MouseButton1Click:Connect(func)
end

-- SPEED
button("⚡ Speed",40,function()
speed = not speed
if speed then
LocalPlayer.Character.Humanoid.WalkSpeed = 50
else
LocalPlayer.Character.Humanoid.WalkSpeed = 16
end
end)

-- JUMP
button("🦘 Jump",80,function()
jump = not jump
if jump then
LocalPlayer.Character.Humanoid.JumpPower = 100
else
LocalPlayer.Character.Humanoid.JumpPower = 50
end
end)

-- NOCLIP
button("👻 Noclip",120,function()
noclip = not noclip
RunService.Stepped:Connect(function()
if noclip and LocalPlayer.Character then
for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
if v:IsA("BasePart") then
v.CanCollide = false
end
end
end
end)
end)

-- INFINITE JUMP
button("♾ Infinite Jump",160,function()
infjump = not infjump
end)

UIS.JumpRequest:Connect(function()
if infjump then
LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
end
end)

-- FLY
button("✈️ Fly",200,function()
fly = not fly

if fly then
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(9e9,9e9,9e9)
bv.Parent = LocalPlayer.Character.HumanoidRootPart

RunService.RenderStepped:Connect(function()
if fly then
bv.Velocity = Camera.CFrame.LookVector * 80
end
end)
else
if LocalPlayer.Character.HumanoidRootPart:FindFirstChildOfClass("BodyVelocity") then
LocalPlayer.Character.HumanoidRootPart:FindFirstChildOfClass("BodyVelocity"):Destroy()
end
end

end)

-- ESP
button("👁 ESP Players",240,function()
for _,p in pairs(Players:GetPlayers()) do
if p ~= LocalPlayer and p.Character then
local hl = Instance.new("Highlight",p.Character)
hl.FillColor = Color3.fromRGB(255,255,255)
end
end
end)

-- CAMERA PLAYER
button("📷 Camera Player",280,function()
for _,p in pairs(Players:GetPlayers()) do
if p ~= LocalPlayer and p.Character then
Camera.CameraSubject = p.Character:FindFirstChild("Humanoid")
break
end
end
end)

-- RESET
button("🔄 Reset Character",320,function()
LocalPlayer.Character.Humanoid.Health = 0
end)
