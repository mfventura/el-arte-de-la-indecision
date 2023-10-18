# Intro

La mecanica principal es la toma de decisiones cotidianas mientras se desarrolla un juego para una JAM estando solo.

[Link a la JAM](https://itch.io/jam/mv-game-jam-vii)

[Link al GDD](https://docs.google.com/document/d/1qgA88J6bowzoB304E9k0muf-_SPkAPVfwgrUjEy9Imc/edit)

[Link al fichero online de traduccion](https://docs.google.com/spreadsheets/d/1cq_5diG7rZ3Upc2hYigxaX0FxAJZgnW1im6-0K1R0xc/edit#gid=0)

# Plugins

- [Radial Progress](https://godotengine.org/asset-library/asset/2193)

# Data Model

The events are stores in a JSON. This document follows the next schema

```json
{
  "events": [
	{
	  "event": "KEY_EVENT",
	  "decisions": [
		{
		  "text": "DECISION_KEY",
		  "consequences": [
			{
			  "key": "hunger",
			  "value": "--"
			},
			{
			  "key": "energy",
			  "value": "-"
			},
			{
			  "key": "motivation",
			  "value": "-"
			},
			{
			  "key": "progress",
			  "value": "++"
			}
		  ]
		},
		{
		  "text": "DECISION_KEY_2",
		  "consequences": [
			{
			  "key": "hunger",
			  "value": "+"
			},
			{
			  "key": "energy",
			  "value": "+"
			},
			{
			  "key": "motivation",
			  "value": "+"
			}
		  ]
		},
		{
		  "text": "DECISION_KEY_3",
		  "consequences": [
			{
			  "key": "hunger",
			  "value": "++"
			},
			{
			  "key": "progress",
			  "value": "+"
			}
		  ]
		}
	  ]
	}
  ]
}
```

For the consequences, the key can be one of the following:

- hunger: That affects the hunger value of the player. The value can be one of the following:
  - ++: The value is increased by 10
  - +: The value is increased by 5
  - --: The value is decreased by 10
  - -: The value is decreased by 5
- energy: That affects the energy value of the player, the values can be the same than the hunger.
- motivation: That affects the motivation value of the player, the values can be the same than the hunger.
- progress: That affects the progress value of the project. The value can be one of the following:
  - ++: The value is increased by 2
  - +: The value is increased by 1
  - --: The value is decreased by 2
  - -: The value is decreased by 1
- money: That affects the quantity of money of the player. The value must be an entire number (-6, -400, 5, 101...). It can not include decimals and it can not be a string.
- time: That affects the time of the game, The value must be a natural number (positive) and it represent the quantity of seconds that will be removed from the timer of the day. It can not include decimals and it can not be a string.
- originality: That value is internally used to calculate the total progress of the project. The values can be the same than the hunger.
- reputation: That value is internally used to calculate the total progress of the project. The values can be the same than the hunger.
- graphics: That value is internally used to calculate the total progress of the project. The values can be the same than the hunger.
- music: That value is internally used to calculate the total progress of the project. The values can be the same than the hunger.

# Autores

- Segaj89
- Ventura
