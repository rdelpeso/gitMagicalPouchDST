require "prefabutil"

local assets=
{
	Asset("ATLAS", "images/inventoryimages/ui_magicpouch_4x4.xml"),
	Asset("IMAGE", "images/inventoryimages/ui_magicpouch_4x4.tex"),
	Asset("ATLAS", "images/inventoryimages/ui_magicpouch_3x3.xml"),
	Asset("IMAGE", "images/inventoryimages/ui_magicpouch_3x3.tex"),
	Asset("ATLAS", "images/inventoryimages/ui_magicpouch_2x2.xml"),
	Asset("IMAGE", "images/inventoryimages/ui_magicpouch_2x2.tex"),
	Asset("ANIM", "anim/magicpouch.zip"),
}

local function ondropped(inst, owner)
    inst.components.container:Close(owner)
end

local function onopen(inst)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_open", "open")
end

local function onclose(inst)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_close", "open")
return (inst)
end

local slotpos = {}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)

	inst:AddTag("magicalpouch")
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("magicpouch.tex")
	
    inst.AnimState:SetBank("magicpouch")
    inst.AnimState:SetBuild("magicpouch")
    inst.AnimState:PlayAnimation("idle")

	if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()
	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.cangoincontainer = true
    inst.components.inventoryitem.atlasname = "images/inventoryimages/magicpouch.xml"

    inst:AddComponent("inspectable")
	
    inst:AddComponent("container")
	inst.components.container:WidgetSetup("magicpouch")
	inst.components.inventoryitem:SetOnDroppedFn(ondropped)
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
	
    return inst
end

return Prefab( "common/magicpouch", fn, assets)
