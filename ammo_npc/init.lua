util.AddNetworkString("npc_voice")
util.AddNetworkString("buy_pistol")
util.AddNetworkString("buy_smg")
util.AddNetworkString("buy_shotgun")
util.AddNetworkString("buy_sniper")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/odessa.mdl")
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:SetSolid(SOLID_BBOX)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()
    self.AutomaticFrameAdvance = true
end

function ENT:AcceptInput(Name, Activator, Caller)
    if Name == "Use" and Caller:IsPlayer() then
        umsg.Start("Dermastart", Caller)
        umsg.End()
    end
end

net.Receive("buy_pistol", function(len, ply)
    if not ply:canAfford(50) then
        net.Start("npc_voice")
        net.Send(ply)
        --umsg.Start("npc_voice_error", ply)
        --umsg.End() 
        DarkRP.notify(ply, 1, 4, string.format("Du kannst dir die Munition nicht leisten."))
    else
        ply:addMoney(-50)
        ply:GiveAmmo(20, "Pistol", false)
    end
end)

net.Receive("buy_smg", function(len, ply)
    if not ply:canAfford(50) then
        --umsg.Start("npc_voice_error", ply)
        net.Start("npc_voice")
        net.Send(ply)
        -- umsg.End()
        DarkRP.notify(ply, 1, 4, string.format("Du kannst dir die Munition nicht leisten."))
    else
        ply:addMoney(-50)
        ply:GiveAmmo(45, "SMG1", false)
    end
end)

net.Receive("buy_shotgun", function(len, ply)
    if not ply:canAfford(50) then
        net.Start("npc_voice")
        net.Send(ply)
        DarkRP.notify(ply, 1, 4, string.format("Du kannst dir die Munition nicht leisten."))
    else
        ply:addMoney(-50)
        ply:GiveAmmo(20, "Buckshot", false)
    end
end)

net.Receive("buy_sniper", function(len, ply)
    if not ply:canAfford(50) then
        net.Start("npc_voice")
        net.Send(ply)
        DarkRP.notify(ply, 1, 4, string.format("Du kannst dir die Munition nicht leisten."))
    else
        ply:addMoney(-50)
        ply:GiveAmmo(6, "357", false)
    end
end)