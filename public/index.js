/** @typedef {{load: (Promise<unknown>); flags: (unknown)}} ElmPagesInit */

/** @type ElmPagesInit */
export default {
  load: async function (elmLoaded) {
    const app = await elmLoaded;
    console.log("App loaded", app);
  },
  flags: function () {
    let flags = { width: window.innerWidth, height: window.innerHeight, year : ( new Date().getFullYear()) };
    return JSON.stringify(flags);
  },
};
