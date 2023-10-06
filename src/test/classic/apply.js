import { DASH_CLASSIC_PATCHES } from "./interface";
import fs from "fs";

const args = process.argv.slice(2);

if (args.length != 1) {
   console.log("Invalid arguments!");
   process.exit(1);
}

let rom = new Uint8Array(fs.readFileSync(args[0]));
DASH_CLASSIC_PATCHES.forEach(p => {
   rom[p.room] = p.patch & 0xFF;
   rom[p.room+1] = (p.patch >> 8) & 0xFF;
});
fs.writeFileSync("classic.sfc",rom);
