# takenncs-atm ATM Robbery Script

## Description
This script allows players to **rob ATMs** on a FiveM server using `ox_target`, `ox_lib`, `ox_inventory`, and the `qb-core` framework. Players can check their bank balance and rob an ATM if they have the required item (`krediitkaart`).

## Installation

1. **Dependencies**:
   - **qb-core** — Core framework for the script.
   - **ox_lib** — Used for various functions.
   - **ox_inventory** — Handles inventory items required for robbery.
   - **ox_target** — Adds interaction to ATMs.

2. **Add the files to your server**:
   - `client.lua`
   - `server.lua`
   - `config.lua`
   - `fxmanifest.lua`

3. **Make sure all dependencies are installed and active on your server.**

4. **Start your server and test the script**:
   - Approach an ATM and use the target interaction menu.
   - Check your balance or rob the ATM if you have the `krediitkaart` item.

## Features

- **ATM interactions**: Use `ox_target` to interact with ATMs.
- **Check balance**: View player cash and bank money.
- **Rob ATM**: Rob the ATM if you have the required card.
- **Cooldown**: ATM is temporarily locked after a robbery.
- **Skillcheck**: Mini skill test during the robbery.
- **Animations and progress bar**: Improved player experience.

## How to Use

1. Approach an ATM and open the interaction menu.
2. View your balance or, if you have the `krediitkaart` item, start the robbery.
3. Complete the skillcheck successfully during the robbery.
4. After a successful robbery, the ATM is locked for the cooldown duration.
5. Receive a cash reward on success.

## License

This project is licensed under the **MIT** license. For details, see the [MIT License](https://opensource.org/licenses/MIT).

## Contact

If you have any questions or suggestions, feel free to contact me:

- **Discord**: takenncss

## Thank You!

Thank you for using the **takenncs-atm** script! We hope it adds excitement and new opportunities to your FiveM server.

# Ox_inventory - item:
   ```bash
    ["krediitkaart"] = {
        label = "Card",
        weight = 0.5, 
        usable = true,
    description = 'Heavy card tbh :O'
    },

