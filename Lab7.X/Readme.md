## Requirements
### Basic
- You will need four LED lights and one button, with the LEDs 
connected to the pins RA0, RA1, RA2, and RA3 in sequence from left to 
right. Additionally, a button is connected to the pin RB0. When the button 
is pressed, the state of the LEDs should be able to toggle. 
### Advance
- Create a cyclic counter ranging from 0x00 to 0x0F with the pins RA0, 
RA1, RA2, and RA3 representing four different bits. This setup should 
control LED lights to count with alternating intervals, starting with a 0.5
second delay, followed by a 1-second delay, and continuing in this 
alternating pattern. You must use TIMER2 to create the proper delay 
interval. You are not allowed to use DELAY macro. 
### Bonus
- Implement a cyclic counter ranging from 0x00 to 0x0F that can count 
both up and down. The timer should have three interval states: 0.25 
seconds, 0.5 seconds, and 1 second. Upon pressing a button, the timer 
should be able to switch both the counting direction and the interval state. 
The initial state is set to count up with a 0.25-second interval. The 
counting direction should cycle through the following pattern: counting up, 
then down, and back to up. The interval timing should progress: 0.25 
second -> 0.5 second -> 1 second, and then back to 0.25 second. The 
state change should occur immediately upon button press. 
