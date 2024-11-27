## Requirements
### Basic
- Please store the value 0x03 at Data Memory address [0x100], and store the value 0x08 
at Data Memory address [0x101]. After that, please use at least one type of indirect 
addressing register to ensure that the values at Data Memory addresses [0x102] 
through [0x108] are all computed as the result of adding or subtracting the values from 
the preceding two addresses.    
When the address contains even values, such as [0x102] or [0x104], the value at the 
current address should be the sum of the values from the previous two addresses. 
Conversely, when the address contains odd values, like [0x103] or [0x105], the value 
at the current address should be computed as the result of subtracting the values from 
the previous two addresses.
### Advance
- Please store the value 0x05 at Data Memory address [0x000], and store the value 0x02 
at Data Memory address [0x018]. After that, please use at least one type of FSR to 
ensure the value at Data Memory address [0x001] represents the sum of the values at 
Data Memory addresses [0x000] and [0x018]. Furthermore, the value of [0x017] is 
obtained by subtracting the value [0x018] from the value [0x000]. Proceed to Data 
Memory address [0x002], where the value should be the sum of the values at Data 
Memory addresses [0x001] and [0x017]. In a similar fashion, the value of [0x016] is 
obtained by subtracting the value [0x017] from the value [0x001], i.e., [0x016] = 
[0x001] – [0x017], and so on.
### Bonus
- Store the values 0xB5, 0xF8, 0x64, 0x7F, 0xA8, and 0x15 at Data Memory addresses 
[0x100] to [0x105], respectively. Implement cocktail sort using at least one type of 
indirect addressing register to arrange the above six values in ascending order. After 
sorting, store the resulting values sequentially at locations [0x110] to [0x115].  
