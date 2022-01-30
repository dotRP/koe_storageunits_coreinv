This script was created by Dalkoe and additional features added by serraz

Simple storage unit script, buy/sell a storage unit to keep items safe, simple animation when using the storage, options to set buy price, sell price, police name and minimum grade. Also define units in the config using qtarget(bt-target) polyzones.

**DEPENDENCIES**
esx_legacy
ox_inventory
PolyZones
qtarget (can be used with BT-Target, just replace every instance of the word qtarget with bt-target and it will work)
nh-context (https://github.com/nerohiro/nh-context)

**OPTIONAL** 
okokNotify (https://forum.cfx.re/t/okoknotify-standalone-paid/3907758)
Any notify system can be used, just search in the client or server lua for okok and replace with your own functions. 


The storage units located under the overpass near downtown can be third eyed and purchased. 
if your police job = 'police' you can breach the units. 

Any questions or issues contact **DalKoe#0019** on discord


**INSTALL**
Setup your channel to log the breaches, in the server.lua paste the webhook url into the url at the top of the lua.

Put koe_storageunits and nh-context in your resource folder 

add this to your cfg. 

start nh-context
start koe_storageunits

add the sql file included to your database. 
