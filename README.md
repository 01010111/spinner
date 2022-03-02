# Spinner

## Changing list items

To change the list, open docs/list.txt, edit it, put one list item per line, then commit the changes. It should be live in a few minutes.

## Changing settings

The settings control various aspects of the spinner. They are all either boolean (`true` or `false`) or numbers (like `0.5`). Here is a list of the different settings:

- **shuffle**: whether or not to shuffle the list before spinning (suggested: true)
- **show_every_list_item**: whether or not the spinner will show every list item at least once before settling on a winner (suggested: true for lists under 50, false for lists over 50 - really large lists will result in really long spins)
- **animate_time_min**: how long a single item will stay on screen while the spinner is running at its fastest in seconds (suggested: 0.01)
- **animate_time_max**: how long a single item will stay on screen while the spinner is running at its slowest in seconds (suggested: 0.6)
- **spin_time**: if `show_every_list_item` is set to `false`, this is how long a spin will last in seconds (suggested: 6)