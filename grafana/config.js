define(['settings'],
function (Settings) {
  return new Settings({
    datasources: {
      graphite: {
        type: 'graphite',
        url: "/graphite",
        default: true
      }
    },
    elasticsearch: '/elasticsearch',

    // default start dashboard
    default_route: '/dashboard/file/default.json',

    // Elasticsearch index for storing dashboards
    grafana_index: "grafana-dash",

    // If TIME_ZONE in graphite is set to UTC, set this to "0000"
    timezoneOffset: 0000,
    unsaved_changes_warning: true,
    playlist_timespan: "1m",
  });
});
