{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 2,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [ 136.0, 143.0, 1000.0, 780.0 ],
        "boxes": [
            {
                "box": {
                    "id": "cTrig",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 20.0, 160.0, 20.0 ],
                    "text": "LANDING TRIGGER"
                }
            },
            {
                "box": {
                    "id": "btn",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 30.0, 50.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "trig",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "bang", "bang", "bang", "bang" ],
                    "patching_rect": [ 70.0, 50.0, 80.0, 22.0 ],
                    "text": "t b b b b"
                }
            },
            {
                "box": {
                    "id": "mStrikeImp",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 170.0, 50.0, 80.0, 22.0 ],
                    "text": "strike 0. -3."
                }
            },
            {
                "box": {
                    "id": "mStrikeFric",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 260.0, 50.0, 84.0, 22.0 ],
                    "text": "strike 0. -2.2"
                }
            },
            {
                "box": {
                    "id": "mFricEnv",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 354.0, 50.0, 90.0, 22.0 ],
                    "text": "1. 3, 0. 140"
                }
            },
            {
                "box": {
                    "id": "mCrumpEnv",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 454.0, 50.0, 90.0, 22.0 ],
                    "text": "1. 5, 0. 180"
                }
            },
            {
                "box": {
                    "id": "lineF",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "bang" ],
                    "patching_rect": [ 354.0, 84.0, 40.0, 22.0 ],
                    "text": "line~"
                }
            },
            {
                "box": {
                    "id": "lineC",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "bang" ],
                    "patching_rect": [ 454.0, 84.0, 40.0, 22.0 ],
                    "text": "line~"
                }
            },
            {
                "box": {
                    "id": "cImp",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 130.0, 140.0, 20.0 ],
                    "text": "IMPACT LAYER"
                }
            },
            {
                "box": {
                    "id": "inImp",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 160.0, 270.0, 22.0 ],
                    "text": "sdt.inertial footImp @mass 0.1 @fragmentSize 1."
                }
            },
            {
                "box": {
                    "id": "modImp",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 290.0, 160.0, 820.0, 22.0 ],
                    "text": "sdt.modal groundImp 4 1 @freqs 90. 180. 320. 620. @decays 0.03 0.025 0.02 0.012 @pickup0 80. 120. 160. 220. @activeModes 4 @fragmentSize 1."
                }
            },
            {
                "box": {
                    "id": "imp",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "signal" ],
                    "patching_rect": [ 30.0, 190.0, 619.0, 22.0 ],
                    "text": "sdt.impact~ footImp groundImp 2 @stiffness 18000000. @dissipation 0.22 @shape 1.45 @contact0 1 @contact1 1"
                }
            },
            {
                "box": {
                    "id": "impGain",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 30.0, 220.0, 52.0, 22.0 ],
                    "text": "*~ 0.8"
                }
            },
            {
                "box": {
                    "id": "cFric",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 265.0, 140.0, 20.0 ],
                    "text": "FRICTION TAIL"
                }
            },
            {
                "box": {
                    "id": "inFric",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 295.0, 270.0, 22.0 ],
                    "text": "sdt.inertial footFric @mass 0.1 @fragmentSize 1."
                }
            },
            {
                "box": {
                    "id": "modFric",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 290.0, 295.0, 760.0, 22.0 ],
                    "text": "sdt.modal groundFric 3 1 @freqs 120. 260. 500. @decays 0.02 0.015 0.01 @pickup0 90. 130. 180. @activeModes 3 @fragmentSize 1."
                }
            },
            {
                "box": {
                    "id": "fric",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "signal" ],
                    "patching_rect": [ 30.0, 325.0, 969.0, 22.0 ],
                    "text": "sdt.friction~ footFric groundFric 2 @stiffness 1600. @dissipation 24. @viscosity 10. @breakAway 0.28 @kDynamic 0.06 @kStatic 0.68 @stribeck 0.07 @noisiness 0.35 @force 0.25"
                }
            },
            {
                "box": {
                    "id": "fricVCA",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 30.0, 355.0, 32.0, 22.0 ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "id": "fricGain",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 70.0, 355.0, 60.0, 22.0 ],
                    "text": "*~ 0.25"
                }
            },
            {
                "box": {
                    "id": "cCr",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 400.0, 180.0, 20.0 ],
                    "text": "SNOW CRUMPLE LAYER"
                }
            },
            {
                "box": {
                    "id": "crump",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "signal" ],
                    "patching_rect": [ 30.0, 430.0, 426.0, 22.0 ],
                    "text": "sdt.crumpling~ @crushingEnergy 0.18 @granularity 0.62 @fragmentation 0.45"
                }
            },
            {
                "box": {
                    "id": "crVCA",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 30.0, 460.0, 32.0, 22.0 ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "id": "crGain",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 70.0, 460.0, 55.0, 22.0 ],
                    "text": "*~ 0.2"
                }
            },
            {
                "box": {
                    "id": "sum1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 540.0, 300.0, 32.0, 22.0 ],
                    "text": "+~"
                }
            },
            {
                "box": {
                    "id": "sum2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 590.0, 340.0, 32.0, 22.0 ],
                    "text": "+~"
                }
            },
            {
                "box": {
                    "id": "master",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 650.0, 380.0, 50.0, 22.0 ],
                    "text": "*~ 0.5"
                }
            },
            {
                "box": {
                    "channels": 1,
                    "id": "gain",
                    "lastchannelcount": 0,
                    "maxclass": "live.gain~",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "signal", "", "float", "list" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 730.0, 382.0, 115.0, 70.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "live.gain~",
                            "parameter_mmax": 6.0,
                            "parameter_mmin": -70.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "live.gain~",
                            "parameter_type": 0,
                            "parameter_unitstyle": 4
                        }
                    },
                    "varname": "live.gain~"
                }
            },
            {
                "box": {
                    "id": "dac",
                    "maxclass": "ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [ 875.0, 390.0, 45.0, 45.0 ]
                }
            },
            {
                "box": {
                    "id": "cSurf",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 530.0, 150.0, 20.0 ],
                    "text": "SURFACE PRESETS"
                }
            },
            {
                "box": {
                    "id": "snowBtn",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 560.0, 45.0, 22.0 ],
                    "text": "snow"
                }
            },
            {
                "box": {
                    "id": "grassBtn",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 85.0, 560.0, 45.0, 22.0 ],
                    "text": "grass"
                }
            },
            {
                "box": {
                    "id": "snowImp",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 150.0, 560.0, 255.0, 22.0 ],
                    "text": "stiffness 9000000., dissipation 0.42, shape 1.8"
                }
            },
            {
                "box": {
                    "id": "snowFric",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 410.0, 560.0, 150.0, 22.0 ],
                    "text": "noisiness 0.18, force 0.15"
                }
            },
            {
                "box": {
                    "id": "snowCr",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 570.0, 560.0, 330.0, 22.0 ],
                    "text": "crushingEnergy 0.42, granularity 0.75, fragmentation 0.55"
                }
            },
            {
                "box": {
                    "id": "grassImp",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 150.0, 590.0, 262.0, 22.0 ],
                    "text": "stiffness 20000000., dissipation 0.2, shape 1.35"
                }
            },
            {
                "box": {
                    "id": "grassFric",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 410.0, 590.0, 150.0, 22.0 ],
                    "text": "noisiness 0.45, force 0.32"
                }
            },
            {
                "box": {
                    "id": "grassCr",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 570.0, 590.0, 330.0, 22.0 ],
                    "text": "crushingEnergy 0.08, granularity 0.45, fragmentation 0.25"
                }
            },
            {
                "box": {
                    "id": "note",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 640.0, 520.0, 20.0 ],
                    "text": "If too quiet: raise live.gain~ and *~ 0.5 master. If too noisy: lower crump gain."
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "trig", 0 ],
                    "source": [ "btn", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "sum2", 1 ],
                    "source": [ "crGain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "crGain", 0 ],
                    "source": [ "crVCA", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "crVCA", 0 ],
                    "source": [ "crump", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "fricVCA", 0 ],
                    "source": [ "fric", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "sum1", 1 ],
                    "source": [ "fricGain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "fricGain", 0 ],
                    "source": [ "fricVCA", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dac", 1 ],
                    "order": 0,
                    "source": [ "gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dac", 0 ],
                    "order": 1,
                    "source": [ "gain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "grassCr", 0 ],
                    "order": 0,
                    "source": [ "grassBtn", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "grassFric", 0 ],
                    "order": 1,
                    "source": [ "grassBtn", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "grassImp", 0 ],
                    "order": 2,
                    "source": [ "grassBtn", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "crump", 0 ],
                    "source": [ "grassCr", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "fric", 0 ],
                    "source": [ "grassFric", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "imp", 0 ],
                    "source": [ "grassImp", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "impGain", 0 ],
                    "source": [ "imp", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "sum1", 0 ],
                    "source": [ "impGain", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "crVCA", 1 ],
                    "source": [ "lineC", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "fricVCA", 1 ],
                    "source": [ "lineF", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "lineC", 0 ],
                    "source": [ "mCrumpEnv", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "lineF", 0 ],
                    "source": [ "mFricEnv", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "inFric", 0 ],
                    "source": [ "mStrikeFric", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "inImp", 0 ],
                    "source": [ "mStrikeImp", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "gain", 0 ],
                    "source": [ "master", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snowCr", 0 ],
                    "order": 0,
                    "source": [ "snowBtn", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snowFric", 0 ],
                    "order": 1,
                    "source": [ "snowBtn", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "snowImp", 0 ],
                    "order": 2,
                    "source": [ "snowBtn", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "crump", 0 ],
                    "source": [ "snowCr", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "fric", 0 ],
                    "source": [ "snowFric", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "imp", 0 ],
                    "source": [ "snowImp", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "sum2", 0 ],
                    "source": [ "sum1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "master", 0 ],
                    "source": [ "sum2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "mCrumpEnv", 0 ],
                    "source": [ "trig", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "mFricEnv", 0 ],
                    "source": [ "trig", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "mStrikeFric", 0 ],
                    "source": [ "trig", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "mStrikeImp", 0 ],
                    "source": [ "trig", 0 ]
                }
            }
        ],
        "parameters": {
            "gain": [ "live.gain~", "live.gain~", 0 ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [ "-", "-", "-", "-", "-", "-", "-", "-" ],
                    "buttons": [ "-", "-", "-", "-", "-", "-", "-", "-" ]
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0
    }
}