/** @typedef {{load: (Promise<unknown>); flags: (unknown)}} ElmPagesInit */

/** @type ElmPagesInit */
const monthNames = ["January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
];

let currentDate = new Date();

export default {
  load: async function (elmLoaded) {
    const app = await elmLoaded;
    console.log("App loaded", app);
  },
  flags: function () {
    return { width: window.innerWidth, height: window.innerHeight, year : ( currentDate.getFullYear()), fullDate : (monthNames[currentDate.getMonth()] + " " + currentDate.getDate() + ", " + currentDate.getFullYear()) };
  },
};
