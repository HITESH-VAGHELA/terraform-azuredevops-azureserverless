import { AzureFunction, Context, HttpRequest } from "@azure/functions"
import { getUserId } from "../Common/Utils";
import { getAllTodoItems } from "../DataAccess/todo-item-repository";
import { NewTodoItem } from "../Models/new-todo-item";
import { TodoItem } from "../Models/todo-item";
import { ToDoItemRecord } from "../Models/todo-item-record";

const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<void> {
    context.log.info('Get all todo items started.');
    
    const todoItems = await getAllTodoItems(getUserId());
    
    if(todoItems && todoItems.length > 0) {
        context.res = {
            status: 200,
            body: todoItems
        };
    } else {
        context.res = {
            status: 204
        };
    }
    
    context.log.info('Get all todo items completed.');
    context.done();
};

export default httpTrigger;