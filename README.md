# Wall App

Wall App is a demo application build with Ruby on Rails. Users can visit the wall and also can post on this common wall. To post on the common wall users have to register on this application using their email and password.

## Table of Contents

[TOC]

## Features

- Registration and Login: Anonymous users can create a new user and this new user
  receives a welcome email. New users can then log in.
- Wall (authed): After logging in, a user can post messages on the site-wide wall, similar
  to a facebook wall except there is only 1 wall for the entire site.
- Wall (guest): Guests as well as authed users can see all of the messages on the wall.

## Technical Specs

- Language: [Ruby](https://www.ruby-lang.org/en/)

- Framework: [Ruby on Rails](https://rubyonrails.org/)

- Authentication Library: [Devise](https://github.com/heartcombo/devise), [jwt](https://github.com/jwt/ruby-jwt)

- Automation Testing Tool: [RSpec](https://github.com/rspec/rspec-rails)



## Project Setup

- Clone git repo
- Install dependent libraries: `bundle install`
- Create database configuration file: Copy `/config/database.example.yml` file and create `config/database.yml` file. Change database name, user name and password.
- Load database schema: `rails db:schema:load`
- Create database tables: `rails db:migrate`
- Run project: `rails s`
- Run automation test: `rake`



## API Documentation

### Registration:

**URL:** *{{base_url}}/api/v1/register*

**Method:** POST

**Parameters:**

| Key      | Type   | Required | Example            |
| -------- | ------ | -------- | ------------------ |
| name     | String | True     | "Tauhidul Islam"   |
| email    | String | True     | "test@example.com" |
| password | String | True     | "12345678"         |

**Success response:**

status_code: 201

response_body: 

```json
{
    "user": {
        "email": "test@example.com",
        "name": "Tauhidul Islam"
    },
    "success": true
}
```

**Error response:**

Status code: 406

Response Body:

```json
{
    "success": false,
    "messages": "Email has already been taken"
}
```



### Login:

**URL:** *{{base_url}}/api/v1/authenticate*

**Method:** POST

**Parameters:**

| Key      | Type   | Required | Example            |
| -------- | ------ | -------- | ------------------ |
| email    | String | True     | "test@example.com" |
| password | String | True     | "12345678"         |

**Success response:**

Status code: 200

Response body:

```json
{
    "success": true,
    "user": {
        "email": "test@example.com",
        "name": "Tauhidul Islam"
    },
    "auth_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3LCJleHBpcnkiOjE1OTM5Njk3NjR9.EKmMC2x-IFHP-Xr1FBdZyGPU6l28Flaojbcgp0ka0Is"
}
```

**Error response:**

Status code: 401

Response body:

```json
{
    "success": false,
    "message": "Invalid email or password"
}
```



### Create Post:

**URL:** *{{base_url}}/api/v1/posts*

**Method:** POST

**Headers:**

| Key        | Type   | Required | Example                                                      |
| ---------- | ------ | -------- | ------------------------------------------------------------ |
| auth_token | String | True     | "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3LCJleHBpcnkiOjE1OTM5Njk3NjR9.EKmMC2x-IFHP-Xr1FBdZyGPU6l28Flaojbcgp0ka0Is" |

**Parameters:**

| Key     | Type   | Required | Example        |
| ------- | ------ | -------- | -------------- |
| content | String | True     | "Test content" |

**Success response:**

Status_code: 201

Response body:

```
{
    "post": {
        "id": 5,
        "content": "Test content"
    },
    "success": true
}
```

**Error response:**

Status_code: 401

Response body:

```json
{
    "success": false,
    "message": "Authentication failed"
}
```



### Get All Posts:

**URL:** *{{base_url}}/api/v1/posts*

**Method:** GET

**Headers:**

| Key        | Type   | Required | Example                                                      |
| ---------- | ------ | -------- | ------------------------------------------------------------ |
| auth_token | String | False    | "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3LCJleHBpcnkiOjE1OTM5Njk3NjR9.EKmMC2x-IFHP-Xr1FBdZyGPU6l28Flaojbcgp0ka0Is" |

**Parameters:** No params required

Success response:

Status_code: 200

Response body:

```json
{
    "posts": [
        {
            "id": 5,
            "content": "Test content",
            "created_at": "2020-07-05T17:37:03.777Z",
            "own_post": true
        },
        {
            "id": 4,
            "content": "This is a test post",
            "created_at": "2020-07-05T17:18:03.526Z",
            "own_post": false
        }
    ],
    "success": true
}
```



### Get single post:

**URL:** *{{base_url}}/api/v1/posts/:id*

**Method:** GET

**Headers:**

| Key        | Type   | Required | Example                                                      |
| ---------- | ------ | -------- | ------------------------------------------------------------ |
| auth_token | String | True     | "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3LCJleHBpcnkiOjE1OTM5Njk3NjR9.EKmMC2x-IFHP-Xr1FBdZyGPU6l28Flaojbcgp0ka0Is" |

**Parameters:** No parameters required

**Success response:**

Status code: 201

Response body:

```json
{
    "post": {
        "id": 4,
        "content": "This is a test post",
        "created_at": "2020-07-05T17:18:03.526Z",
        "own_post": false
    },
    "success": true
}
```

**Error response:**

Status_code: 404

szxResponse body:

```json
{
    "success": false,
    "message": "Requested post not available"}
```



### Update Post:

**URL:** *{{base_url}}/api/v1/posts/:id*

**Method:** PUT

**Headers:**

| Key        | Type   | Required | Example                                                      |
| ---------- | ------ | -------- | ------------------------------------------------------------ |
| auth_token | String | True     | "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3LCJleHBpcnkiOjE1OTM5Njk3NjR9.EKmMC2x-IFHP-Xr1FBdZyGPU6l28Flaojbcgp0ka0Is" |

**Parameters:**

| Key     | Type   | Required | Example                |
| ------- | ------ | -------- | ---------------------- |
| content | String | True     | "Test content updated" |

**Success response:**

Status_code: 202

Response body:

```json
{
    "post": {
        "id": 5,
        "content": "Test content updated",
        "created_at": "2020-07-05T17:37:03.777Z",
        "own_post": true
    },
    "message": "Updated successfully",
    "success": true
}
```

**Error response:**

Status_code: 401

Response body:

```json
{
    "success": false,
    "message": "Unauthorized request"
}
```

Status_code: 404

Response body:

```json
{
    "success": false,
    "message": "Requested post not available"
}
```

### Delete Post:

**URL:** *{{base_url}}/api/v1/posts/:id*

**Method:** DELETE

**Headers:**

| Key        | Type   | Required | Example                                                      |
| ---------- | ------ | -------- | ------------------------------------------------------------ |
| auth_token | String | True     | "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3LCJleHBpcnkiOjE1OTM5Njk3NjR9.EKmMC2x-IFHP-Xr1FBdZyGPU6l28Flaojbcgp0ka0Is" |

**Parameters:** No parameters required

**Success response:**

Status_code: 202

```json
{
    "post": {
        "id": 5,
        "content": "Test content updated",
        "created_at": "2020-07-05T17:37:03.777Z",
        "own_post": true
    },  "message": "Deleted successfully",  "success": true}
```

Error response:

Status_code: 401

```json
{
    "success": false,
    "message": "Unauthorized request"
}
```

Status_code: 404

```json
{
    "success": false,
    "message": "Requested post not available"
} 
```
