// This only works if 'Appearance' in the settings menu is set to 'Auto'.
// It controls the in-game time for automatic theme switching.
window.cfg = {};
window.cfg.timeSyncAppearance = {
    day : 5,   // At 5:00 AM (in-game), the HUD will switch to Dark Mode.
    night : 21 // At 9:00 PM (21:00) (in-game), the HUD will switch to White Mode.
}

// Controls the smoothness of the compass animation when the player moves the camera.
window.cfg.compassSmoothness = 0.05

// This is a performance and visual setting for the compass.
// true: Displays rounded values (e.g., 290, 300).
// false: Displays exact, non-rounded values (e.g., 294, 301).
// Note: Setting to 'false' can be visually 'noisier' and may have a minor performance impact.
window.cfg.compassValueRoundedToNearestTen = true

window.cfg.logo = {
    state : true, 
    src : `../dist/img/logo.png`,
    letPlayersMoveAndResizeTheLogo : true,
    letPlayersDisableTheLogo : true
}

window.cfg.essentialsElements = {
    health : {
        label : 'Health',
        icon : '<i class="fa-solid fa-heart"></i>'
    },
    armor : {
        label : 'Armor',
        icon: '<i class="fa-solid fa-shield"></i>'
    },
    thirst : {
        label : 'Thirst',
        icon : '<i class="fa-solid fa-bottle-water"></i>'
    },
    hunger : {
        label : 'Hunger',
        icon : '<i class="fa-solid fa-burger"></i>'
    },
    stamina : {
        label : 'Stamina',
        icon : '<i class="fa-solid fa-lungs"></i>'
    },
    mic : {
        label : 'Microphone',
        icon : '<i class="fa-solid fa-microphone"></i>'
    }
}

window.cfg.playerStatsElements = {
    horizontal : {
        playerId : {
            state : true,
            label : 'Player ID',
            icon : '<i class="fa-solid fa-tags"></i>'
        },
        playerCount : {
            state : true,
            label : 'Online Players',
            icon : '<i class="fa-solid fa-users"></i>'
        },
        date : {
            state : true,
            label : 'Clock',
            icon : '<i class="fa-solid fa-clock"></i>'
        },
    },
    vertical : {
        userGroup : {
            state : true,
            label : 'Group',
            icon : '<i class="fa-solid fa-user-shield"></i>'
        },
        userJob : {
            state : true,
            label : 'Job',
            icon : '<i class="fa-solid fa-briefcase"></i>'
        },
        wallet : {
            state : true,
            label : 'Cash',
            icon : '<i class="fa-solid fa-wallet"></i>',
            currency : '$',
            TransactionNotify : true
        },
        bank : {
            state : true,
            label : 'Bank',
            icon : '<i class="fa-solid fa-building-columns"></i>',
            currency : '$',
            TransactionNotify : true
        },
        walletDirty : {
            state : true,
            label : 'Dirty Cash',
            icon : '<i class="fa-solid fa-money-bill-wave"></i>',
            currency : '$',
            TransactionNotify : true
        },
        postal : {
            state : true,
            label : 'Postal',
            icon : '<i class="fa-solid fa-map-pin"></i>'
        },
        weapon : {
            state : true,
            label : 'Weapon'
        },
    },

}

window.cfg.langAndVisibility = {
    menuCategory : {
        expandWidth : '15vh',
        essentials : {
            state : true,
            label : 'Essentials', 
            icon : '<i class="fa-solid fa-icons"></i>'
        },
        statsClock : {
            state: true, 
            label : 'Stats & Clock',
            icon : '<i class="fa-solid fa-user"></i>'
        },
        locationCompass : {
            state: true, 
            label : 'Location & Compass',
            icon : '<i class="fa-solid fa-location-dot"></i>'
        },
        vehicle : {
            state : true, 
            label : 'Vehicle',
            icon : '<i class="fa-solid fa-gas-pump"></i>'
        },
        aircraft : {
            state : true, 
            label : 'Aircraft',
            icon : '<i class="fa-solid fa-plane"></i>'
        },
        submarine : {
            state : true, 
            label : 'Submarine',
            icon : '<i class="fa-solid fa-water-ladder"></i>'
        },
        minimap : {
            state : true, 
            label : 'Minimap',
            icon : '<i class="fa-solid fa-map"></i>'
        },
        settings : {
            state : true, 
            label : 'Settings',
            icon : '<i class="fa-solid fa-gear"></i>',
            configEditor : true
        }
    },
    essentials : {
        styles : {
            verticalProgressBar  : {
                state : true,
                label : 'Vertical Progress Bar'
            },
            horizontalProgressBar : {
                state : true, 
                label : 'Horizontal Progress Bar'
            },
            iconProgressBar : {
                state : true, 
                label : 'Icon & Progress Bar'
            },
            circleBorderBar : {
                state : true,
                label : 'Circle Border Bar'
            },
            circlePercent : {
                state : true, 
                label : 'Circle Percent'
            },
            diamondShape : {
                state : true,
                label : 'Diamond Shape'
            },
            squareBorderBar : {
                state : true, 
                label : 'Square Border Bar'
            },
            square : {
                state : true,
                label : 'Square'
            },
            hexagonBorderBar : {
                state : true,
                label : 'Hexagon Border Bar'
            },
            hexagon : {
                state : true, 
                label : 'Hexagon'
            },
            triangleBorderBar : {
                state : true, 
                label : 'Triangle Border Bar'
            }
        }
    },
    speedometers : {
        styles : {
            vehicles : {
                type1 : {
                    state : true,
                    label : 'Classic Compact'
                },
                type2 : {
                    state : true,
                    label : 'Classic'
                },
                type3 : {
                    state : true,
                    label : 'Minimal'
                },
                type4 : {
                    state : true, 
                    label : 'Performance'
                },
                type5 : {
                    state : true, 
                    label : 'Analog'
                }
            },
            aircraft : {
                type6 : {
                    state : true, 
                    label : 'Digital'
                },
                type7 : {
                    state : true,
                    label : 'Analog'
                }
            },
            submarine : {
                type8 : {
                    state : true,
                    label : 'Digital'
                },
                type9 : {
                    state : true,
                    label : 'Analog'
                }
            }
        }
    },
    colors : {
        mainProgressEmptyProgressBar : {
            label : 'Empty Progress Bar'
        },
        mainProgressEmptyProgressBarDark : {
            label : 'Empty Progress Bar Dark'
        },
        mainPercentColor : {
            label : 'Percent Color'
        },
        backgroundProgressMainIcon : {
            label : 'Icon'
        },
        statsHudValue : {
            label : 'Value'
        },
        statsHudHeader : {
            label : 'Label'
        },
        statsHudIcon : {
            label : 'Icon Ghost Mode'
        },
        statsHudIconSolid : {
            label : 'Icon Solid Mode'
        },
        statsHudBackgroundSolid : {
            label : 'Icon Background Solid Mode'
        },
        statsHudIconBackground : {
            label : 'Icon Background Ghost Mode'
        },
        weaponAmmo : {
            label : 'Loaded Ammo'
        },
        weaponTotalAmmo : {
            label : 'Total Ammo'
        },
        statsHudBackgroundLightMode : {
            label : 'Background Light Mode'
        },
        statsHudBackgroundDarkMode : {
            label : 'Background Dark Mode'
        },
        pozitiveTransactionNotify : {
            label : 'TransactionNotify (+)'
        },
        negativeTransactionNotify : {
            label : 'TransactionNotify (-)'
        },
        directionsColor : {
            label : 'Street'
        },
        directionColor2 : {
            label : 'District'
        },
        directionCircleColor : {
            label : 'Panels Background'
        },
        directionCircleColorGhostLight : {
            label : 'Panels Background'
        },
        directionTextColor : {
            label : 'Panels Value'
        },
        directionTextColorGhost : {
            label : 'Panels Value'
        },
        directionBoxBackgroundLight : {
            label : 'Container Background'
        },
        directionBoxBackgroundDark : {
            label : 'Container Background Dark'
        },
        compassPrimary : {
            label : 'Primary Color'
        },
        compassBackgroundLight : {
            label : 'Container Background Light'
        },
        compassBackgroundDark : {
            label : 'Container Background Dark'
        },
        vehicleCharge : {
            label : 'Battery'
        },
        gasVehicle : {
            label : 'Gas'
        },
        speedometerRedLine : {
            label : `'Red' Line`
        },
        rpmColor : {
            label : 'Rpm'
        },
        speed : {
            label : 'Speed'
        },
        gearContainer : {
            label : 'Gears Background'
        },
        gearText : {
            label : 'Gears Text'
        },
        darkTick : {
            label : 'Ticks'
        },
        lightTick : {
            label : 'Ticks'
        },
        tickText : {
            label : 'Ticks Text'
        },
        gaugeTicksColor : {
            label : 'Gauge'
        },
        type5BackgroundColor : {
            label : 'Background Light Mode'
        },
        type5BackgroundColorDark : {
            label : 'Background Dark Mode'
        },
        airCraftPrimaryColor : {
            label : 'Primary Color'
        },
        airCraftRollSky : {
            label : 'Horizon'
        },
        airCraftRollEarth : {
            label : 'Ground'
        },
        airCraftArrow : {
            label : 'Indicator Arrow'
        },
        airCraftRoll2 : {
            label : 'Wing Marker'
        },
        speedUnit : {
            label : 'Labels'
        },
        airCraftRoll : {
            label : 'Wing Marker'
        },
        submarinePrimaryColor : {
            label : 'Primary Color'
        },
        entitiesOnRadar : {
            label : 'Sonar Entities'
        },
        mapBorderColor : {
            label : 'Map Border Color'
        },
    
    },
    others : {
        appearance : {
            label : 'Appearance',
            switches : {
                light : {
                    label : 'Light'
                },
                dark : {
                    label : 'Dark'
                },
                auto : {
                    label : 'Auto'
                }
            }
        },
        performanceMode : {
            label : 'Performance Mode'
        },
        makeThisConfigurationDefault : {
            label : 'Set as Default',
            icon : '<i class="fa-solid fa-hammer"></i>'
        },
        resetDefault : {
            label : 'Reset to Default',
            icon : '<i class="fa-solid fa-trash-can-arrow-up"></i>'
        },
        saveConfig : {
            label : 'Save',
            icon : '<i class="fa-solid fa-cloud-arrow-up"></i>'
        },
        configFileHeader : {
        label : 'Config File',
        icon : '<i class="fa-solid fa-file"></i>'
        },
        editMode : {
            button : {
                label : 'Edit Mode',
                icon : '<i class="fa-solid fa-arrows-up-down-left-right"></i>'
            },
            editModeActive : {
                title : {
                    label : 'EDIT MODE ACTIVE',
                },
                subtitle : {
                    icon : '<i class="fa-solid fa-arrow-pointer"></i>',
                    label : 'Click & Drag to move'
                },
                snapLines : {
                    label : 'Snap Lines'
                },
                individualMode : {
                    label : 'Individual Mode'
                }
            }
        },
        hideAfterValue : {
            label : 'Hide Threshold'
        },
        hideValueType : {
            label : 'Hide Value Type',
            selectors : {
                before : {
                    label : 'Before Value'
                },
                after : {
                    label : 'After Value'
                }
            }
        },
        alignX : {
            label  : 'Align (X)',
            switches : {
            left : {
                label : 'Left'
            },
            center : {
                label : 'Center'
            },
            right : {
                label : 'Right'
            }
            }
        },
        alignY : {
            label : 'Align (Y)',
            switches : {
                top : {
                    label : 'Top'
                },
                center : {
                    label : 'Center'
                },
                bot : {
                    label : 'Bottom'
                }
            }
        },
        reverse : {
            label : 'Reverse Align'
        },
        progressBarLength : {
            label : 'Progress Bar Length'
        },
        talkingAnimation : {
            label : 'Talking Animation',
            selectors : {
                moveUp : {
                    label : 'Move Up'
                },
                moveDown : {
                    label : 'Move Down'
                },
                moveLeft : {
                    label : 'Move Left'
                },
                moveRight : {
                    label : 'Move Right'
                },
                scale : {
                    label : 'Scale'
                },
                opacity : {
                    label : 'Opacity'
                },
                noAnimation : {
                    label : 'None'
                }
            }
        },
        roundIconn : {
            label : 'Shape',
            switches : {
                square : {
                    label : 'Square'
                },
                round : {
                    label : 'Circle'
                }
            }
        },
        hideHeader : {
            label : 'Label',
            switches : {
                show : {
                    label : 'Show'
                },
                hide : {
                    label : 'Hide'
                }
            }
        },
        iconBackground : {
            label : 'Icon',
            switches : {
                solid : {
                    label : 'Ghost'
                },
                ghost : {
                    label : 'Solid'
                }
            }
        },
        reverseAlign : {
            label : 'Reverse Align',
        },
        alwaysVisibleWeapon : {
            label : 'Always Show (Weapon)'
        },
        square : {
            label : 'Shape',
            switches : {
                circle : {
                    label : 'Circle'
                },
                square : {
                    label : 'Square'
                }
            }
        },
        ghost : {
            label : 'Items Bg',
            switches : {
                solid : {
                    label : 'Solid'
                },
                ghost : {
                    label : 'Ghost'
                }
            }
        },
        reverseAlign : {
            label : 'Reverse Align'
        },
        reverseIconWithCardinal : {
            label : 'Reverse Panels'
        },
        alwaysVisible : {
            label : 'Always Visible'
        },
        primaryPanelHide : {
            label : 'Primary Panel'
        },
        secondaryPanelHide : {
            label : 'Secondary Panel'
        },
        streetNameHide : {
            label : 'Street Name'
        },
        districtHide : {
            label : 'District'
        },
        compassHide : {
            label : 'Compass'
        },
        alwaysVisibleCompass : {
            label : 'Always Visible'
        },
        reverseAlignCompass : {
            label : 'Reverse Align'
        },
        animationState : {
            label : 'Red Line Animation'
        },
        layout2 : {
            label : 'Layout',
            switches : {
                l1 : {
                    label : '1'
                },
                l2 : {
                    label : '2'
                }
            }
        },
        gearsRound : {
            label : 'Gears Background Shape',
            switches : {
                squareGears : {
                    label : 'Square'
                },
                circleGears : {
                    label : 'Circle'
                }
            }
        },
        speedUnit : {
            label : 'Speed Unit',
            switches : {
                squareGears : {
                    label : 'KMH'
                },
                circleGears : {
                    label : 'MPH'
                }
            }
        },
        depthUnit : {
            label : 'Depth Unit',
            switches : {
                mUnit : {
                    label : 'M'
                },
                ftUnit : {
                    label : 'FT'
                }
            }
        },
        altUnit : {
            label : 'Altitude Unit',
            switches : {
                mUnit : {
                    label : 'M'
                },
                ftUnit : {
                    label : 'FT'
                }
            }
        },
        animationType : {
            label : 'Red Line Animation Type',
            switches : {
                squareGears : {
                    label : 'Shake'
                },
                circleGears : {
                    label : 'Pulse'
                }
            }
        },
        ticksVisibility : {
            label : 'Ticks'
        },
        gaugeVisibility : {
            label : 'Gauge'
        },
        gearsVisibility : {
            label : 'Gears'
        },
        fuelVisibility : {
            label : 'Fuel'
        },
        speedVisibility : {
            label : 'Speed'
        },
        labelsVisibility : {
            label : 'Labels'
        },
        altitudeVisiblity : {
            label : 'Altitude'
        },
        wingVisibility : {
            label : 'Wing Marker'
        },
        horizonVisibility : {
            label : 'Artificial Horizon Container'
        },
        clearanceVisibility : {
            label : 'Clearance'
        },
        depthVisibility : {
            label : 'Depth'
        },
        sonarVisibility : {
            label : 'Sonar'
        },
        minimapBorderFade : {
            label : 'Faded Border'
        },
        radarVisibleOnlyInCar : {
            label : 'Visible only in vehicles'
        },
        stretchRezolution : {
            label : 'Stretch Aspect Ratio'
        },
        opacity : {
            label : 'Opacity'
        }
    },
    map : {
        styles : {
            square : {
                state : true,
                label : 'Rectangle'
            },
            squareround : {
                state : true, 
                label : 'Rounded Rectangle'
            },
            circle : {
                state : true, 
                label : 'Circle'
            }
        }
    },
    categoryHeaders : {
        style : {
            label : 'STYLE',
            icon : '<i class="fa-solid fa-shapes"></i>'
        },
        colors : {
            label : 'COLORS',
            icon : '<i class="fa-solid fa-palette"></i>'
        },
        visibilityAlwaysVisible : {
            label : 'VISIBILITY - ALWAYS VISIBLE',
            icon : '<i class="fa-solid fa-eye"></i>'
        },
        elementsAlign : {
            label : 'ELEMENTS ALIGN',
            icon : '<i class="fa-solid fa-align-center"></i>'
        },
        others : {
            label : 'OTHERS',
            icon : '<i class="fa-solid fa-box-open"></i>'
        },
        elementsVisibility : {
            label : 'ELEMENTS VISIBILITY',
            icon : '<i class="fa-solid fa-eye"></i>'
        },
        shape : {
            label : 'SHAPE',
            icon : '<i class="fa-solid fa-shapes"></i>'
        },
        appearanceCustomization : {
            label : 'APPEARANCE & CUSTOMIZATION',
            icon : '<i class="fa-solid fa-palette"></i>'
        },
        compassCustomization : {
            label : 'COMPASS CUSTOMIZATION',
            icon : '<i class="fa-solid fa-compass"></i>'
        },
        main : {
            label : 'MAIN',
            icon : '<i class="fa-solid fa-house"></i>'
        }
    }
}