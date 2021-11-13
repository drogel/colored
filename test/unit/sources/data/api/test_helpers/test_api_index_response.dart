const failingApiIndexResponse = {"testEntry": "testValue"};

const testIndex = [
  {
    "title": "colors",
    "endpoint": "https://test.com/colors/{hex}",
    "entries": [
      {
        "title": "colors_search",
        "entries": [
          {
            "title": "colors_search_hexes",
            "endpoint": "https://test.com/colors/search/hexes?hex={hex}",
            "entries": [
              {
                "title": "colors_search_closest",
                "endpoint":
                    "https://test.com/colors/search/hexes/closest?hex={hex}"
              }
            ]
          },
          {
            "title": "colors_search_names",
            "endpoint": "https://test.com/colors/search/names?name={name}"
          }
        ]
      }
    ]
  },
  {
    "title": "palettes",
    "endpoint": "https://test.com/palettes/{id}",
    "entries": [
      {
        "title": "palettes_search",
        "entries": [
          {
            "title": "palettes_search_names",
            "endpoint": "https://test.com/palettes/search/names?name={name}"
          }
        ]
      }
    ]
  },
  {
    "title": "suggestions",
    "entries": [
      {
        "title": "colors_suggestions",
        "endpoint": "https://test.com/suggestions/colors/{hex}",
        "entries": [
          {
            "title": "random_colors_suggestions",
            "endpoint": "https://test.com/suggestions/colors/random"
          },
          {
            "title": "colors_suggestions_search",
            "entries": [
              {
                "title": "colors_suggestions_search_hexes",
                "endpoint":
                    "https://test.com/suggestions/colors/search/hexes?hex={hex}",
                "entries": [
                  {
                    "title": "colors_suggestions_search_closest",
                    "endpoint":
                        "https://test.com/suggestions/colors/search/hexes/closest?hex={hex}"
                  }
                ]
              },
              {
                "title": "colors_suggestions_search_names",
                "endpoint":
                    "https://test.com/suggestions/colors/search/names?name={name}"
              }
            ]
          }
        ]
      },
      {
        "title": "palettes_suggestions",
        "endpoint": "https://test.com/suggestions/palettes/{id}",
        "entries": [
          {
            "title": "random_palettes_suggestions",
            "endpoint": "https://test.com/suggestions/palettes/random"
          },
          {
            "title": "palettes_suggestions_search_names",
            "endpoint":
                "https://test.com/suggestions/palettes/search/names?name={name}"
          }
        ]
      }
    ]
  }
];

const testApiIndexResponse = {
  "apiVersion": "0.2.1",
  "method": "GET",
  "data": {
    "kind": "index_entry",
    "currentItemCount": 3,
    "itemsPerPage": 10,
    "startIndex": 1,
    "totalItems": 3,
    "pageIndex": 1,
    "totalPages": 1,
    "selfLink": "https://test.com/",
    "items": [
      {
        "title": "côlòrs",
        "endpoint": "https://test.com/colors/{hex}",
        "entries": [
          {
            "title": "colors_search",
            "entries": [
              {
                "title": "colors_search_hexes",
                "endpoint": "https://test.com/colors/search/hexes?hex={hex}",
                "entries": [
                  {
                    "title": "colors_search_closest",
                    "endpoint":
                        "https://test.com/colors/search/hexes/closest?hex={hex}"
                  }
                ]
              },
              {
                "title": "colors_search_names",
                "endpoint": "https://test.com/colors/search/names?name={name}"
              }
            ]
          }
        ]
      },
      {
        "title": "palettes",
        "endpoint": "https://test.com/palettes/{id}",
        "entries": [
          {
            "title": "palettes_search",
            "entries": [
              {
                "title": "palettes_search_names",
                "endpoint": "https://test.com/palettes/search/names?name={name}"
              }
            ]
          }
        ]
      },
      {
        "title": "suggestions",
        "entries": [
          {
            "title": "colors_suggestions",
            "endpoint": "https://test.com/suggestions/colors/{hex}",
            "entries": [
              {
                "title": "random_colors_suggestions",
                "endpoint": "https://test.com/suggestions/colors/random"
              },
              {
                "title": "colors_suggestions_search",
                "entries": [
                  {
                    "title": "colors_suggestions_search_hexes",
                    "endpoint":
                        "https://test.com/suggestions/colors/search/hexes?hex={hex}",
                    "entries": [
                      {
                        "title": "colors_suggestions_search_closest",
                        "endpoint":
                            "https://test.com/suggestions/colors/search/hexes/closest?hex={hex}"
                      }
                    ]
                  },
                  {
                    "title": "colors_suggestions_search_names",
                    "endpoint":
                        "https://test.com/suggestions/colors/search/names?name={name}"
                  }
                ]
              }
            ]
          },
          {
            "title": "palettes_suggestions",
            "endpoint": "https://test.com/suggestions/palettes/{id}",
            "entries": [
              {
                "title": "random_palettes_suggestions",
                "endpoint": "https://test.com/suggestions/palettes/random"
              },
              {
                "title": "palettes_suggestions_search_names",
                "endpoint":
                    "https://test.com/suggestions/palettes/search/names?name={name}"
              }
            ]
          }
        ]
      }
    ]
  }
};
