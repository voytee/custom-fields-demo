# custom-fields-demo

## How to run it?

- it uses docker-compose to run postgresql db
- please run `docker-compose up` to run database
- next run `rails db:prepare` to set up database
- there are some seeds prepared so after you run it, you should have some data in the db to play with

## Implementation

This demo shows how to implement custom fields on a model.
Such fields can be added dynamicaly to objects of a given model so it can have many of those fields.
For the purpose of this demo we will focus on 4 types of custom fields:

- text
- number
- single-select
- multiple-select

Each of those fields can have its own validations defined similary to other non-custom fields

- Number field has also its default validation that checks numericality of the value provided
- Single-select field has default validation that checks the inclusion of value in the options provided
- Multiple-select field has default validation that checks the inclusion of all selected values in the provided options.

- Aside from that, you can define other validations on each field that are going to be added to the default validation rules.

### Data structure
`CustomField` model represents the definition of custom fields attached to `User` model (`User has_many CustomFields`)

`User` model stores all custom fields values in the jsonb type column


### Side note
There are some comments in the code explaining the implementation, however I am a huge fan of self-documented code - meaning that the code should be readable and easy to understand. That's why
I have payed a lot of attention to proper naming of methods and variables and keeping code simple.

Also for simplicity and to focus on solving the main problem the implementation should not be considered final.

In a real world example I'd create a concern / plugin `CustomFieldsHolder` that could be used on any model in the app (not only User model)
The relation between `TargetModel` and `CustomField` would be then polymorphic.

For the sake of simplicity I haven't used FormObjects and ServiceObjects / Commands which I would normally do to encapsulate business logic

### How to test it

In the console find `User.first` and check their `custom_fields` `User.first.custom_fields`
and try to update some of them `age, nickname, role, interests` (Check the validation rules defined in custom_fields to try out the validations)

Run `rails server` and try updating record using the API endpoint

You can use commands like this:
```curl -X PATCH localhost:3000/users/1 -d"user[age]=30" -d"user[nickname]='speedy'" -d"user[role]=admin" -d"user[interests][]=cars" -d"user[interests][]=technology"``` (successfull)

or this

```curl -X PATCH localhost:3000/users/1 -d"user[age]=-1" -d"user[nickname]='s'" -d"user[role]=badass" -d"user[interests][]=girls" -d"user[interests][]=technology"``` (validation errors)
