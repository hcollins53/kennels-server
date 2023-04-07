DATABASE = {
    "animals":[{
        "id": 1,
        "name": "Snickers",
        "species": "Dog",
        "locationId": 1,
        "customerId": 3,
        "status": "Admitted"
    },
    {
        "id": 2,
        "name": "Roman",
        "species": "Dog",
        "locationId": 1,
        "customerId": 2,
        "status": "Admitted"
    },
    {
        "id": 3,
        "name": "Blue",
        "species": "Cat",
        "locationId": 2,
        "customerId": 1,
        "status": "Admitted"
    }],
    "customers":[{
        "id": 1,
        "name": "Ryan Tanay"
    },
    {
        "id": 2,
        "name": "Anthony Hall"
    },
    {
        "id": 3,
        "name": "Bethany Mitchell"
    }],
    "employees":[{
        "id": 1,
        "name": "Jenna Solis",
        "location_id": 1
    }],
    "locations":[{
        "id": 1,
        "name": "Nashville North",
        "address": "8422 Johnson Pike"
    },
    {
        "id": 2,
        "name": "Nashville South",
        "address": "209 Emory Drive"
    }]
}


def all(resource):
    """For GET requests to collection"""
    return DATABASE[resource]


def retrieve(resource, id):
    """For GET requests to a single resource"""
    requested = None
    for one_resource in DATABASE[resource]:
        if one_resource["id"] == id:
            requested = one_resource
    return requested


def create(resource, resource_object):
    """For POST requests to a collection"""
    max_id = DATABASE[resource][-1]["id"]
    new_id = max_id + 1
    resource_object["id"] = new_id
    DATABASE[resource].append(resource_object)
    return resource_object


def update(id, new_object, resource):
    """For PUT requests to a single resource"""
    resource_list = DATABASE[resource]
    for index, new_resource in enumerate(resource_list):
        if new_resource["id"] == id:
            resource_list[index] = new_object
            break


def delete(id, resource):
    """For DELETE requests to a single resource"""
    resource_index = -1
    for index, one_resource in enumerate(DATABASE[resource]):
        if one_resource["id"] == id:
            resource_index = index
    if resource_index >= 0:
        DATABASE[resource].pop(resource_index)
        