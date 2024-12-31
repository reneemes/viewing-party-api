# Viewing Part API - Solo Project

## About this Application

Viewing Party is an application that allows users to explore movies and create a Viewing Party Event that invites users and keeps track of a host. Once completed, this application will collect relevant information about movies from an external API, provide CRUD functionality for creating a Viewing Party and restrict its use to only verified users. 

## Setup

1. Fork and clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{drop,create,migrate,seed}`

Run the application and test out some endpoints: `rails s`

## Endpoints

### Get All Users
Request: `GET api/v1/users`

Response:
```
{
    "data": [
        {
            "id": "1",
            "type": "user",
            "attributes": {
                "name": "Danny DeVito",
                "username": "danny_de_v"
            }
        },
        {
            "id": "2",
            "type": "user",
            "attributes": {
                "name": "Dolly Parton",
                "username": "dollyP"
            }
        },
        {
            "id": "3",
            "type": "user",
            "attributes": {
                "name": "Lionel Messi",
                "username": "futbol_geek"
            }
        }
    ]
}
```

### Create a User
Request: `POST api/v1/users`
```
{
  "name": "Jane",
  "username": "JaneDoe",
  "password": "Password",
  "password_confirmation": "Password"
}
```

Response:
```
{
  "data": {
    "id": "4",
    "type": "user",
    "attributes": {
        "name": "Jane",
        "username": "JaneDoe",
        "api_key": "dcFKHwGN6XYL51VGanLVQVnA"
    }
  }
}

```

### Top 20 Movies
Request: `GET api/v1/movies`

Response:
```
{
  "data": [
    {
      "id": "278",
      "type": "movie",
      "attributes": {
          "title": "The Shawshank Redemption",
          "vote_average": 8.708
      }
    },
    {
      "id": "238",
      "type": "movie",
      "attributes": {
          "title": "The Godfather",
          "vote_average": 8.7
      }
    },
  {
      "id": "240",
      "type": "movie",
      "attributes": {
          "title": "The Godfather Part II",
          "vote_average": 8.6
      }
    },...
  ]
}
```
### Get One Movie
Request: `GET api/v1/movies/:movie_id`

Response:
```
{
  "data": {
    "id": "411",
    "type": "movie",
    "attributes": {
      "title": "The Chronicles of Narnia: The Lion, the Witch and the Wardrobe",
      "release_year": "2005",
      "vote_average": 7.134,
      "runtime": "2 hours, 23 minutes",
      "genres": [
        "Adventure",
        "Family",
        "Fantasy"
      ],
      "summary": "Siblings Lucy, Edmund, Susan and Peter step through a magical wardrobe and find the land of Narnia...",
      "cast": [
        {
          "character": "Peter Pevensie",
          "actor": "William Moseley"
        },
        First 10 Cast Members...
      ],
      "total_reviews": 8,
      "reviews": [
        {
          "author": "r96sk",
          "review": "Long bloody title, but a great film no doubt..."
        },
        First 5 Reviews...
      ]
    }
  }
}
```

### Create a Viewing Party
Request: `POST api/v1/parties`
```
{
  "name": "Jane's Bday Movie Bash!",
  "start_time": "2025-02-01 10:00:00",
  "end_time": "2025-02-01 14:30:00",
  "movie_id": 278,
  "movie_title": "The Shawshank Redemption",
  "api_key": "API KEY HERE",
  "invitees": [user_id, user_id]
}
```

Response:
```
{
  "data": {
    "id": "1",
    "type": "party",
    "attributes": {
      "name": "Juliet's Bday Movie Bash!",
      "start_time": "2025-02-01T10:00:00.000Z",
      "end_time": "2025-02-01T14:30:00.000Z",
      "movie_id": 278,
      "movie_title": "The Shawshank Redemption"
    },
    "relationships": {
      "users": {
       "data": [
          {
            "id": "1",
            "type": "user"
          },
          {
            "id": "2",
            "type": "user"
          },
          {
            "id": "3",
            "type": "user"
          }
        ]
      }
    }
  }
}
```

### Update a Viewing Party - Adding a User
Request: `PATCH api/v1/parties/:party_id`
```
{
  "api_key": "API KEY HERE",
  "invitees": [user_id]
}
```
Response:
```
{
    "data": {
        "id": "1",
        "type": "party",
        "attributes": {
            "name": "Dolly's Viewing Party!",
            "start_time": "2025-02-01T10:00:00.000Z",
            "end_time": "2025-02-01T14:30:00.000Z",
            "movie_id": 278,
            "movie_title": "The Shawshank Redemption"
        },
        "relationships": {
            "users": {
                "data": [
                    {
                        "id": "1",
                        "type": "user"
                    },
                    {
                        "id": "2",
                        "type": "user"
                    },
                    {
                        "id": "3",
                        "type": "user"
                    },
                    {
                        "id": "4",
                        "type": "user"
                    }
                ]
            }
        }
    }
}
```


<!-- * Endpoints 1-3 do not require an API key to retrieve:</br>
  * Top 20 movies
  * Movies that meet the search keywords
  * A detailed list of information for one specific movie
* Endpoint 4-5 require an API key be present and valid for:</br>
  * Creating a new viewing party
  * Adding additional invitees after party creation -->

<!-- ## Deployment -->
<!-- https://stormy-beach-63044-805e1c9fd02b.herokuapp.com/ -->