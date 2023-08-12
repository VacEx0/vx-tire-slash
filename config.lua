Config = {}

Config.slashDistance = 1.0 -- Distance to the tire a players should be.
Config.prompt = 'Slash Tire' -- Button name.

Config.subDurability = 5.0 -- >0 will remove this much durability from the weapon, otherwise nothing will happen.

Config.animDict = 'melee@knife@streamed_core'
Config.animName = 'ground_attack_on_spot' -- Animation to play when slashing a tire.
Config.animTime = 750 -- How long the animation should play.
Config.animWait = 500 -- How long after the animation plays to burst the tire.

Config.weapons = { -- Weapons that may be used to slash tires.
    'WEAPON_KNIFE'
}

Config.wheelBones = { -- I dont recommended changing these, however these are the wheel ids/bones that may be slashed.
    [0] = 'wheel_lf', -- bike, plane or jet front  
    [1] = 'wheel_rf', --
    [2] = 'wheel_lm', -- in 6 wheels trailer, plane or jet is first one on left  
    [3] = 'wheel_rm', -- in 6 wheels trailer, plane or jet is first one on right  
    [4] = 'wheel_lr', -- bike rear / in 6 wheels trailer, plane or jet is last one on left  
    [5] = 'wheel_rr', -- in 6 wheels trailer, plane or jet is last one on right  
}