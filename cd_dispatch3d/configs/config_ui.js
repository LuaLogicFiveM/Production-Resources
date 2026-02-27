// *Model notes
// If you are adding custom models be aware of their polygon counts and file sizes.
// The map is already pretty heavy on polygons, so if adding new models make sure their polygon count is low and file size is small.

// The higher polygon counts won't make a difference on higher end machines, but on lower end machines it will cause stuttering and lag.
// This is also the reason why we are using the lowest quality GTA 5 models by default.

// Besides adding an entry here for the custom model, you will also need to add the model to the models/placeable folder in the correct format.
// THE MODEL MUST BE IN **.GLB** FORMAT.

// The map also supports DRACO compression for the models.

window['models'] = {
    police: // Job name. Change this to the name of your job. This is used in the code and should be unique.
        {
            car:{ // Car model configuration. Do not change the name "car" as it is used in the code.
                file_name: "police.glb", // File name of the vehicle/ped model inside the models/placeable folder.
                scale: 2, // Scale of the model. 1 is default scale. Adjust as needed. Can use decimals (E.g. 0.01 or 0.1 and so on)
                position_adjustment: { // Position adjustment for the model. Adjust as needed. Shifts the model in the X, Y and Z axis.
                    x: 0,
                    y: 0,
                    z: 0,
                },
                rotation_adjustment: { // Rotation adjustment for the model in DEGREES. Adjust as needed. Correct rotation enables heading tracking.
                    x: 0,
                    y: 0,
                    z: 0,
                }
            },
            foot: {
                file_name: "s_m_y_cop_01.glb",
                scale: 3,
                position_adjustment: {
                    x: 0,
                    y: 0,
                    z: 0,
                },
                rotation_adjustment: {
                    x: 0,
                    y: 0,
                    z: 0,
                }
            },
            helicopter : {
                file_name: "polmav.glb",
                scale: 2,
                position_adjustment: {
                    x: 0,
                    y: 0,
                    z: 0,
                },
                rotation_adjustment: {
                    x: 0,
                    y: 0,
                    z: 0,
                }
            },
            boat : {
                file_name: "predator.glb",
                scale: 2,
                position_adjustment: {
                    x: 0,
                    y: 0,
                    z: 0,
                },
                rotation_adjustment: {
                    x: 0,
                    y: 0,
                    z: 0,
                }
            },
            motorcycle: {
                file_name: "policeb.glb",
                scale: 2,
                position_adjustment: {
                    x: 0,
                    y: 0,
                    z: 0,
                },
                rotation_adjustment: {
                    x: 0,
                    y: 0,
                    z: 0,
                }
            }
    },
    ambulance: {
        car:{ 
            file_name: "ambulance.glb",
            scale: 2,
            position_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            },
            rotation_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            }
        },
        foot: {
            file_name: "s_m_m_doctor_01.glb",
            scale: 3,
            position_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            },
            rotation_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            }
        },
    },
    mechanic: {
        car:{ 
            file_name: "towtruck4.glb",
            scale: 2,
            position_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            },
            rotation_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            }
        },
        foot: {
            file_name: "s_m_m_autoshop_02.glb",
            scale: 3,
            position_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            },
            rotation_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            }
        }
    },
    fire: {
        car:{ 
            file_name: "firetruk.glb",
            scale: 2,
            position_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            },
            rotation_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            }
        },
        foot: {
            file_name: "s_m_y_fireman_01.glb",
            scale: 3,
            position_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            },
            rotation_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            }
        }
    },
    taxi: {
        car:{ 
            file_name: "taxi.glb",
            scale: 2,
            position_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            },
            rotation_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            }
        },
    },
    // The default model list is used if the job does not have an entry in the models object.
    // The entries of the default model list are used as a fallback if the job does not have an entry in the models object for the specific mode of transport.
    default: {
        car:{ 
            file_name: "tailgater2.glb",
            scale: 2,
            position_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            },
            rotation_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            }
        },
        foot: {
            file_name: "ig_tylerdix_02.glb",
            scale: 2,
            position_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            },
            rotation_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            }
        },
        helicopter : {
            file_name: "maverick.glb",
            scale: 2,
            position_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            },
            rotation_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            }
        },
        boat : {
            file_name: "dinghy.glb",
            scale: 2,
            position_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            },
            rotation_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            }
        },
        motorcycle: {
            file_name: "bati.glb",
            scale: 2,
            position_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            },
            rotation_adjustment: {
                x: 0,
                y: 0,
                z: 0,
            }
        }
    }
}


// List of available status messages and their colors.
window['status_messages'] = [
    {name:"Available", color:"#198754"}, // The status will default to the first one in the list
    {name:"Unavailable", color:"#ff5d57"},
    {name:"Processing", color:"#fd7e14"},
    {name:"Training", color:"#0d6efd"},
    {name:"Undercover", color:"#6f42c1"},
  ];

window['transport_icons'] = {
    motorcycle: `<svg fill="#fff" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" xml:space="preserve"><path d="M256 345.043c-27.619 0-50.087 22.468-50.087 50.087v66.783C205.913 489.532 228.381 512 256 512s50.087-22.468 50.087-50.087V395.13c0-27.619-22.468-50.087-50.087-50.087"/><path d="M422.957 66.783h-85.161C330.04 28.724 296.316 0 256 0s-74.04 28.724-81.795 66.783H89.044c-9.217 0-16.696 7.473-16.696 16.696s7.479 16.696 16.696 16.696h85.161c3.612 17.723 12.915 33.352 25.833 45.068-54.187 22.761-92.439 76.395-92.439 138.584V404.37c0 22.521 18.315 40.848 40.836 40.848h24.087V395.13c0-46.032 37.446-83.478 83.478-83.478s83.478 37.446 83.478 83.478v50.087h25.935c22.521 0 40.848-18.326 40.848-40.848V283.826c0-62.655-38.855-116.587-93.788-139.048 12.652-11.665 21.759-27.115 25.323-44.604h85.161c9.217 0 16.696-7.473 16.696-16.696s-7.479-16.695-16.696-16.695M256 133.565c-27.619 0-50.087-22.468-50.087-50.087S228.381 33.391 256 33.391s50.087 22.468 50.087 50.087-22.468 50.087-50.087 50.087"/></svg>`,
    foot: '<svg xmlns="http://www.w3.org/2000/svg" fill="#fff" viewBox="0 0 320 512"><!--!Font Awesome Free 6.7.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M160 48a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zM126.5 199.3c-1 .4-1.9 .8-2.9 1.2l-8 3.5c-16.4 7.3-29 21.2-34.7 38.2l-2.6 7.8c-5.6 16.8-23.7 25.8-40.5 20.2s-25.8-23.7-20.2-40.5l2.6-7.8c11.4-34.1 36.6-61.9 69.4-76.5l8-3.5c20.8-9.2 43.3-14 66.1-14c44.6 0 84.8 26.8 101.9 67.9L281 232.7l21.4 10.7c15.8 7.9 22.2 27.1 14.3 42.9s-27.1 22.2-42.9 14.3L247 287.3c-10.3-5.2-18.4-13.8-22.8-24.5l-9.6-23-19.3 65.5 49.5 54c5.4 5.9 9.2 13 11.2 20.8l23 92.1c4.3 17.1-6.1 34.5-23.3 38.8s-34.5-6.1-38.8-23.3l-22-88.1-70.7-77.1c-14.8-16.1-20.3-38.6-14.7-59.7l16.9-63.5zM68.7 398l25-62.4c2.1 3 4.5 5.8 7 8.6l40.7 44.4-14.5 36.2c-2.4 6-6 11.5-10.6 16.1L54.6 502.6c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L68.7 398z"/></svg>',
    car: '<svg xmlns="http://www.w3.org/2000/svg" fill="#fff" viewBox="0 0 512 512"><!--!Font Awesome Free 6.7.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M135.2 117.4L109.1 192l293.8 0-26.1-74.6C372.3 104.6 360.2 96 346.6 96L165.4 96c-13.6 0-25.7 8.6-30.2 21.4zM39.6 196.8L74.8 96.3C88.3 57.8 124.6 32 165.4 32l181.2 0c40.8 0 77.1 25.8 90.6 64.3l35.2 100.5c23.2 9.6 39.6 32.5 39.6 59.2l0 144 0 48c0 17.7-14.3 32-32 32l-32 0c-17.7 0-32-14.3-32-32l0-48L96 400l0 48c0 17.7-14.3 32-32 32l-32 0c-17.7 0-32-14.3-32-32l0-48L0 256c0-26.7 16.4-49.6 39.6-59.2zM128 288a32 32 0 1 0 -64 0 32 32 0 1 0 64 0zm288 32a32 32 0 1 0 0-64 32 32 0 1 0 0 64z"/></svg>',
    helicopter:'<svg xmlns="http://www.w3.org/2000/svg" fill="#fff" viewBox="0 0 640 512"><!--!Font Awesome Free 6.7.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M128 32c0-17.7 14.3-32 32-32L544 0c17.7 0 32 14.3 32 32s-14.3 32-32 32L384 64l0 64 32 0c88.4 0 160 71.6 160 160l0 64c0 17.7-14.3 32-32 32l-160 0-64 0c-20.1 0-39.1-9.5-51.2-25.6l-71.4-95.2c-3.5-4.7-8.3-8.3-13.7-10.5L47.2 198.1c-9.5-3.8-16.7-12-19.2-22L5 83.9C2.4 73.8 10.1 64 20.5 64L48 64c10.1 0 19.6 4.7 25.6 12.8L112 128l208 0 0-64L160 64c-17.7 0-32-14.3-32-32zM384 320l128 0 0-32c0-53-43-96-96-96l-32 0 0 128zM630.6 425.4c12.5 12.5 12.5 32.8 0 45.3l-3.9 3.9c-24 24-56.6 37.5-90.5 37.5L256 512c-17.7 0-32-14.3-32-32s14.3-32 32-32l280.2 0c17 0 33.3-6.7 45.3-18.7l3.9-3.9c12.5-12.5 32.8-12.5 45.3 0z"/></svg>',
    boat: '<svg xmlns="http://www.w3.org/2000/svg" fill="#fff" viewBox="0 0 576 512"><!--!Font Awesome Free 6.7.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M192 32c0-17.7 14.3-32 32-32L352 0c17.7 0 32 14.3 32 32l0 32 48 0c26.5 0 48 21.5 48 48l0 128 44.4 14.8c23.1 7.7 29.5 37.5 11.5 53.9l-101 92.6c-16.2 9.4-34.7 15.1-50.9 15.1c-19.6 0-40.8-7.7-59.2-20.3c-22.1-15.5-51.6-15.5-73.7 0c-17.1 11.8-38 20.3-59.2 20.3c-16.2 0-34.7-5.7-50.9-15.1l-101-92.6c-18-16.5-11.6-46.2 11.5-53.9L96 240l0-128c0-26.5 21.5-48 48-48l48 0 0-32zM160 218.7l107.8-35.9c13.1-4.4 27.3-4.4 40.5 0L416 218.7l0-90.7-256 0 0 90.7zM306.5 421.9C329 437.4 356.5 448 384 448c26.9 0 55.4-10.8 77.4-26.1c0 0 0 0 0 0c11.9-8.5 28.1-7.8 39.2 1.7c14.4 11.9 32.5 21 50.6 25.2c17.2 4 27.9 21.2 23.9 38.4s-21.2 27.9-38.4 23.9c-24.5-5.7-44.9-16.5-58.2-25C449.5 501.7 417 512 384 512c-31.9 0-60.6-9.9-80.4-18.9c-5.8-2.7-11.1-5.3-15.6-7.7c-4.5 2.4-9.7 5.1-15.6 7.7c-19.8 9-48.5 18.9-80.4 18.9c-33 0-65.5-10.3-94.5-25.8c-13.4 8.4-33.7 19.3-58.2 25c-17.2 4-34.4-6.7-38.4-23.9s6.7-34.4 23.9-38.4c18.1-4.2 36.2-13.3 50.6-25.2c11.1-9.4 27.3-10.1 39.2-1.7c0 0 0 0 0 0C136.7 437.2 165.1 448 192 448c27.5 0 55-10.6 77.5-26.1c11.1-7.9 25.9-7.9 37 0z"/></svg>',
    dispatcher: `<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-headset" viewBox="0 0 16 16"><path d="M8 1a5 5 0 0 0-5 5v1h1a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V6a6 6 0 1 1 12 0v6a2.5 2.5 0 0 1-2.5 2.5H9.366a1 1 0 0 1-.866.5h-1a1 1 0 1 1 0-2h1a1 1 0 0 1 .866.5H11.5A1.5 1.5 0 0 0 13 12h-1a1 1 0 0 1-1-1V8a1 1 0 0 1 1-1h1V6a5 5 0 0 0-5-5"/></svg>`,
}
