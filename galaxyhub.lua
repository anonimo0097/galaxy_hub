local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local noclip = false
local infjump = false
local flying = false

-- GUI
local gui = Instance.new("ScreenGui",game.CoreGui)

local main = Instance.new("Frame",gui)
main.Size = UDim2.new(0,450,0,300)
main.Position = UDim2.new(0.35,0,0.3,0)
main.BackgroundColor3 = Color3.fromRGB(30,30,30)
main.Active = true
main.Draggable = true

-- TOP
local top = Instance.new("Frame",main)
top.Size = UDim2.new(1,0,0,30)
top.BackgroundColor3 = Color3.fromRGB(45,45,45)

local title = Instance.new("TextLabel",top)
title.Size = UDim2.new(0.6,0,1,0)
title.Text = "UNIVERSAL HUB"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

local minimize = Instance.new("TextButton",top)
minimize.Size = UDim2.new(0.2,0,1,0)
minimize.Position = UDim2.new(0.6,0,0,0)
minimize.Text = "-"
minimize.BackgroundColor3 = Color3.fromRGB(70,70,70)

local close = Instance.new("TextButton",top)
close.Size = UDim2.new(0.2,0,1,0)
close.Position = UDim2.new(0.8,0,0,0)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(120,40,40)

close.MouseButton1Click:Connect(function()
gui:Destroy()
end)

minimize.MouseButton1Click:Connect(function()
main.Visible = not main.Visible
end)

-- LAYOUT
local tabFrame = Instance.new("Frame",main)
tabFrame.Size = UDim2.new(0,120,1,-30)
tabFrame.Position = UDim2.new(0,0,0,30)
tabFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)

local content = Instance.new("Frame",main)
content.Size = UDim2.new(1,-120,1,-30)
content.Position = UDim2.new(0,120,0,30)
content.BackgroundTransparency = 1

Instance.new("UIListLayout",tabFrame)

function createTab(name)
local b = Instance.new("TextButton",tabFrame)
b.Size = UDim2.new(1,0,0,40)
b.Text = name
b.BackgroundColor3 = Color3.fromRGB(60,60,60)
b.TextColor3 = Color3.new(1,1,1)
return b
end

function createPage()
local p = Instance.new("Frame",content)
p.Size = UDim2.new(1,0,1,0)
p.Visible = false
p.BackgroundTransparency = 1
Instance.new("UIListLayout",p)
return p
end

function createButton(parent,text,callback)
local b = Instance.new("TextButton",parent)
b.Size = UDim2.new(1,0,0,35)
b.Text = text
b.BackgroundColor3 = Color3.fromRGB(70,70,70)
b.TextColor3 = Color3.new(1,1,1)
b.MouseButton1Click:Connect(callback)
end

-- PAGES
local playerPage = createPage()
local tpPage = createPage()
local visualPage = createPage()
local trollPage = createPage()

playerPage.Visible = true

createTab("Player").MouseButton1Click:Connect(function()
playerPage.Visible=true tpPage.Visible=false visualPage.Visible=false trollPage.Visible=false
end)

createTab("Teleport").MouseButton1Click:Connect(function()
playerPage.Visible=false tpPage.Visible=true visualPage.Visible=false trollPage.Visible=false
end)

createTab("Visual").MouseButton1Click:Connect(function()
playerPage.Visible=false tpPage.Visible=false visualPage.Visible=true trollPage.Visible=false
end)

createTab("Troll").MouseButton1Click:Connect(function()
playerPage.Visible=false tpPage.Visible=false visualPage.Visible=false trollPage.Visible=true
end)

-- PLAYER
createButton(playerPage,"Speed",function()
LocalPlayer.Character.Humanoid.WalkSpeed = 50
end)

createButton(playerPage,"Jump",function()
LocalPlayer.Character.Humanoid.JumpPower = 100
end)

createButton(playerPage,"Fly",function()

if flying then return end
flying = true

local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.MaxForce = Vector3.new(1e9,1e9,1e9)
bodyVelocity.Parent = LocalPlayer.Character.HumanoidRootPart

RunService.RenderStepped:Connect(function()

if flying then
bodyVelocity.Velocity = Camera.CFrame.LookVector * 80
end

end)

end)

createButton(playerPage,"Noclip",function()
noclip = true
end)

RunService.Stepped:Connect(function()
if noclip and LocalPlayer.Character then
for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
if v:IsA("BasePart") then
v.CanCollide=false
end
end
end
end)

createButton(playerPage,"Infinite Jump",function()
infjump = true
end)

UIS.JumpRequest:Connect(function()
if infjump then
LocalPlayer.Character.Humanoid:ChangeState("Jumping")
end
end)

createButton(playerPage,"Reset Character",function()
LocalPlayer.Character:BreakJoints()
end)

createButton(playerPage,"Desativar Poderes",function()

LocalPlayer.Character.Humanoid.WalkSpeed = 16
LocalPlayer.Character.Humanoid.JumpPower = 50

noclip=false
infjump=false
flying=false

end)

-- TELEPORT
createButton(tpPage,"Teleport Random Player",function()

local list = Players:GetPlayers()
local target = list[math.random(1,#list)]

if target.Character then
LocalPlayer.Character.HumanoidRootPart.CFrame =
target.Character.HumanoidRootPart.CFrame
end

end)

createButton(tpPage,"Teleport Player",function()

for _,p in pairs(Players:GetPlayers()) do
if p ~= LocalPlayer and p.Character then

LocalPlayer.Character.HumanoidRootPart.CFrame =
p.Character.HumanoidRootPart.CFrame

break
end
end

end)

-- VISUAL
createButton(visualPage,"ESP Players",function()

for _,p in pairs(Players:GetPlayers()) do
if p ~= LocalPlayer and p.Character then

local h = Instance.new("Highlight",p.Character)
h.FillColor = Color3.new(1,1,1)
h.OutlineColor = Color3.new(1,1,1)

end
end

end)

createButton(visualPage,"Box ESP",function()

for _,p in pairs(Players:GetPlayers()) do
if p ~= LocalPlayer and p.Character then

local box = Instance.new("SelectionBox")
box.Adornee = p.Character
box.Parent = p.Character

end
end

end)

-- TROLL
createButton(trollPage,"Camera Player",function()

for _,p in pairs(Players:GetPlayers()) do
if p ~= LocalPlayer and p.Character then

Camera.CameraSubject = p.Character.Humanoid

break
end
end

end)
