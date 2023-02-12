"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.createTodoItem = exports.editTodoItem = exports.deleteTodoItem = exports.getAllTodoItems = void 0;
const cosmos_1 = require("@azure/cosmos");
function getCosmosDbContainer() {
    const cosmosDbConnectionString = process.env["shdevdb_DOCUMENTDB"];
    const client = new cosmos_1.CosmosClient(cosmosDbConnectionString);
    const database = client.database("todocontainer");
    const container = database.container("todoItems");
    return container;
}
function getAllTodoItems(userId) {
    return __awaiter(this, void 0, void 0, function* () {
        const querySpec = {
            query: `SELECT * from c WHERE c.userId = '${userId}'`
        };
        const container = getCosmosDbContainer();
        const { resources: todoItems } = yield container.items
            .query(querySpec)
            .fetchAll();
        return todoItems.map(item => {
            return {
                id: item.id,
                userId: item.userId,
                title: item.title,
                description: item.description
            };
        });
    });
}
exports.getAllTodoItems = getAllTodoItems;
function deleteTodoItem(id, userId) {
    return __awaiter(this, void 0, void 0, function* () {
        const container = getCosmosDbContainer();
        const { resource: result } = yield container.item(id, userId).delete();
        return result;
    });
}
exports.deleteTodoItem = deleteTodoItem;
function editTodoItem(id, userId, todoItem) {
    return __awaiter(this, void 0, void 0, function* () {
        const container = getCosmosDbContainer();
        const { resource: updatedItem } = yield container
            .item(id, userId)
            .replace(todoItem);
        return updatedItem;
    });
}
exports.editTodoItem = editTodoItem;
function createTodoItem(todoItem) {
    return __awaiter(this, void 0, void 0, function* () {
        const container = getCosmosDbContainer();
        const { resource: createdItem } = yield container.items.create(todoItem);
        return createdItem;
    });
}
exports.createTodoItem = createTodoItem;
//# sourceMappingURL=todo-item-repository.js.map