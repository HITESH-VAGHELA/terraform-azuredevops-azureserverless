import { CosmosClient } from "@azure/cosmos";
import { ToDoItemRecord } from "../Models/todo-item-record";

function getCosmosDbContainer() {
    //const cosmosDbConnectionString = process.env["shdevdb_DOCUMENTDB"];
    const cosmosDbConnectionString = "AccountEndpoint=https://shdevdb-dev.documents.azure.com:443/;AccountKey=m8exBQGtyeL8HGoxHSfwJCsqRIyXhmD5dN8aWWNs34wwiYBUz0ob1n0jiNRUUOXUEViTnApYQgubACDbVdndNQ==;"
    const client = new CosmosClient(cosmosDbConnectionString);
    const database = client.database("todocontainer");
    const container = database.container("todoItems");

    return container;
}

export async function getAllTodoItems(userId: string): Promise<ToDoItemRecord[]> {
    const querySpec = {
        query: `SELECT * from c WHERE c.userId = '${userId}'` 
      };
      
    const container = getCosmosDbContainer();
    const { resources: todoItems } = await container.items
        .query(querySpec)
        .fetchAll();

    return todoItems.map(item => {
        return {
            id: item.id,
            userId: item.userId,
            title: item.title,
            description: item.description
        } as ToDoItemRecord;
    });
}

export async function deleteTodoItem(id: string, userId: string): Promise<any> {
    const container = getCosmosDbContainer();
    const { resource: result } = await container.item(id, userId).delete();
    return result;
}

export async function editTodoItem(id: string, userId: string, todoItem: ToDoItemRecord): Promise<ToDoItemRecord> {
    const container = getCosmosDbContainer();
    const { resource: updatedItem } = await container
                                        .item(id, userId)
                                        .replace(todoItem);
    return updatedItem;
}

export async function createTodoItem(todoItem: ToDoItemRecord) {
    const container = getCosmosDbContainer();
    const { resource: createdItem } = await container.items.create(todoItem);
    return createdItem;
}