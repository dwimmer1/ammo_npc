surface.CreateFont("MainFont", {
    font = "Comic Sans MS", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    size = 40,
    weight = 500,
})

include("shared.lua")

local function Draw3DText(pos, ang, scale, text)
    local text = "Munitions Händler"
    cam.Start3D2D(pos, ang, scale)
    draw.DrawText(text, "MainFont", 0, 0, Color(255, 250, 250), TEXT_ALIGN_CENTER)
    cam.End3D2D()
end

function ENT:Draw()
    self:DrawModel()
    local mins, maxs = self:GetModelBounds()
    local pos = self:GetPos() + Vector(0, 0, maxs.z + 9) -- x, y, h
    local ang = Angle(0, SysTime() * 0 % 280, 90) --x
    ang:RotateAroundAxis(Vector(0, 0, 1), 90)--neigung
    Draw3DText(pos, ang, 0.2, text, true)
end

local function myMenu()
--net.Receive("dermastart", function()

    local npc_begruesung = {}
    npc_begruesung[1] = "Was brauchst du?"
    npc_begruesung[2] = "Kann man helfen?"
    npc_begruesung[3] = "Pssss. Hier gibts die beste Munition"
    chat.PlaySound() --Chat tick sound
    
    local npc_voice = {}
    npc_voice[1] = "vo/npc/male01/hi01.wav"
    npc_voice[2] = "vo/npc/male01/hi02.wav"
    -- vo/npc/male01/letsgo01.wav"
    surface.PlaySound(table.Random(npc_voice))
    chat.AddText(Color(255, 255, 255), table.Random(npc_begruesung))
    
    local frame = vgui.Create("DFrame")
    frame:SetSize(600, 720)
    frame:Center()
    frame:SetVisible(true)
    frame:MakePopup()
    frame:SetTitle("Munitions Verkäufer")
    frame.Paint = function(s, w, h)
        draw.RoundedBox(12, 0, 0, w, h, Color(105, 105, 105, 150)) ---Allgemeines Derma-Menümenü
        draw.RoundedBox(12, 2, 2, w - 4, h - 4, Color(0, 0, 0, 150)) --das auch nur Außenlinie
        draw.RoundedBox(20, 28, 40, 545, 65, Color(192, 192, 192, 100)) --1
        draw.RoundedBox(20, 28, 130, 545, 65, Color(192, 192, 192, 100)) --2
        draw.RoundedBox(20, 28, 220, 545, 65, Color(192, 192, 192, 100)) --3
        draw.RoundedBox(20, 28, 310, 545, 65, Color(192, 192, 192, 100)) --4
    end

    local Icon1 = vgui.Create("SpawnIcon", frame)
    Icon1:SetPos(30, 40)
    Icon1:SetModel("models/Items/BoxSRounds.mdl")
    Icon1:SetTooltip(nil)
    --Icon1:SetParent(frame)
    local icon2 = vgui.Create("SpawnIcon", frame)
    icon2:SetPos(30, 130)
    icon2:SetModel("models/Items/BoxMRounds.mdl")
    icon2:SetTooltip(nil)
    local icon3 = vgui.Create("SpawnIcon", frame)
    icon3:SetPos(30, 220)
    icon3:SetModel("models/Items/BoxBuckshot.mdl")
    icon3:SetTooltip(nil)
    local icon4 = vgui.Create("SpawnIcon", frame)
    icon4:SetPos(30, 310)
    icon4:SetModel("models/Items/357ammobox.mdl")
    icon4:SetTooltip(nil)
    local button = vgui.Create("DButton", frame) --Button
    button:SetMouseInputEnabled(true)
    button:SetPos(400, 54)
    button:SetSize(90, 35)
    button:SetText("Für 50€ Kaufen")
    local button2 = vgui.Create("DButton", frame)
    button2:SetPos(400, 143)
    button2:SetSize(90, 35)
    button2:SetText("Für 50€ Kaufen")
    button2:SetMouseInputEnabled(true)
    local button3 = vgui.Create("DButton", frame)
    button3:SetPos(400, 233)
    button3:SetSize(90, 35)
    button3:SetText("Für 50€ Kaufen")
    button3:SetMouseInputEnabled(true)
    local button4 = vgui.Create("DButton", frame)
    button4:SetPos(400, 323)
    button4:SetSize(90, 35)
    button4:SetText("Für 50€ Kaufen")
    button4:SetMouseInputEnabled(true)
    local info1 = vgui.Create("DLabel", frame)
    info1:SetText("Pistolen Munition")
    info1:SetTextColor(Color(0, 0, 0))
    info1:SetFont("MainFont")
    info1:SetSize(300, 30)
    info1:SetPos(120, 55)
    local info2 = vgui.Create("DLabel", frame)
    info2:SetText("SMG Munition")
    info2:SetTextColor(Color(0, 0, 0))
    info2:SetFont("MainFont")
    info2:SetSize(300, 30)
    info2:SetPos(120, 145)
    local info3 = vgui.Create("DLabel", frame)
    info3:SetText("Shotgun Munition")
    info3:SetTextColor(Color(0, 0, 0))
    info3:SetFont("MainFont")
    info3:SetSize(300, 40)
    info3:SetPos(120, 230)
    local info4 = vgui.Create("DLabel", frame)
    info4:SetText("Sniper Munition")
    info4:SetTextColor(Color(0, 0, 0))
    info4:SetFont("MainFont")
    info4:SetSize(300, 40)
    info4:SetPos(120, 320)

 
    net.Receive("npc_voice", function(len, ply)
        local npc_voice_2 = {}
        npc_voice_2[1] = "vo/canals/shanty_go_nag03.wav"
        npc_voice_2[2] = "vo/canals/shanty_go_nag01.wav"
        npc_voice_2[3] = "vo/npc/male01/notthemanithought01.wav"
        surface.PlaySound(table.Random(npc_voice_2))
    end)

    function button:OnMousePressed()
        net.Start("buy_pistol")
        net.SendToServer()
    end

    function button2:OnMousePressed()
        net.Start("buy_smg")
        net.SendToServer()
    end

    function button3:OnMousePressed()
        net.Start("buy_shotgun")
        net.SendToServer()
    end

    function button4:OnMousePressed()
        net.Start("buy_sniper")
        net.SendToServer()
    end
end

usermessage.Hook("Dermastart", myMenu)
