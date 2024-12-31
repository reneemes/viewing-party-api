# Viewing Part API - Solo Project

## About this Application

Viewing Party is an application that allows users to explore movies and create a Viewing Party Event that invites users and keeps track of a host. This application collects relevant information about movies from an external API, provide CRUD functionality for creating a Viewing Party and restrict its use to only verified users. 

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
### Search for Movie by Title
Request: `GET api/v1/movies?query=Lord of the Rings`

Response:
```
{
  "data": [
    {
      "id": "839033",
      "type": "movie",
      "attributes": {
        "title": "The Lord of the Rings: The War of the Rohirrim",
        "vote_average": 6.831
      }
    },
    {
      "id": "120",
      "type": "movie",
      "attributes": {
        "title": "The Lord of the Rings: The Fellowship of the Ring",
        "vote_average": 8.4
      }
    },
    First 20 Results...
  ]
}
```

### Get One Movie
Request: `GET api/v1/movies/:movie_id`

Response:
```
{
  "data": {
    "id": "120",
    "type": "movie",
    "attributes": {
      "title": "The Lord of the Rings: The Fellowship of the Ring",
      "release_year": "2001",
      "vote_average": 8.416,
      "runtime": "2 hours, 59 minutes",
      "genres": [
        "Adventure",
        "Fantasy",
        "Action"
      ],
      "summary": "Young hobbit Frodo Baggins, after inheriting a mysterious ring from his uncle Bilbo, must leave his home in order to keep it from falling into the hands of its evil creator. Along the way, a fellowship is formed to protect the ringbearer and make sure that the ring arrives at its final destination: Mt. Doom, the only place where it can be destroyed.",
      "cast": [
        {
          "character": "Frodo",
          "actor": "Elijah Wood"
        },
          First 10 Cast Members...
      ],
      "total_reviews": 5,
      "reviews": [
        {
          "author": "gdeveloper",
          "review": "An epic movie if I ever saw one. Captivating and just plain fun to watch. This movie is, indeed, art."
        },
          Top 5 Reviews...
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