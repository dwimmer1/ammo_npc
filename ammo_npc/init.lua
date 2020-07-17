util.AddNetworkString("npc_voice")
util.AddNetworkString("ammo_buy")

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

net.Receive("ammo_buy", function(len, ply)
    local str = net.ReadString()

    if str == "pistol" then
        if not ply:canAfford(50) then
            net.Start("npc_voice")
            net.Send(ply)
            DarkRP.notify(ply, 1, 4, string.format("Du kannst dir die Munition nicht leisten."))
        else
            ply:addMoney(-50)
            ply:GiveAmmo(20, "Pistol", false)
        end
    end

    if str == "smg" then
        if not ply:canAfford(50) then
            net.Start("npc_voice")
            net.Send(ply)
            DarkRP.notify(ply, 1, 4, string.format("Du kannst dir die Munition nicht leisten."))
        else
            ply:addMoney(-50)
            ply:GiveAmmo(45, "SMG1", false)
        end
    end

    if str == "shotgun" then
        if not ply:canAfford(50) then
            net.Start("npc_voice")
            net.Send(ply)
            DarkRP.notify(ply, 1, 4, string.format("Du kannst dir die Munition nicht leisten."))
        else
            ply:addMoney(-50)
            ply:GiveAmmo(20, "Buckshot", false)
        end
    end

    if str == "sniper" then
        if not ply:canAfford(50) then
            net.Start("npc_voice")
            net.Send(ply)
            DarkRP.notify(ply, 1, 4, string.format("Du kannst dir die Munition nicht leisten."))
        else
            ply:addMoney(-50)
            ply:GiveAmmo(6, "357", false)
        end
    end
end)
