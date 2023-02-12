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
const Utils_1 = require("../Common/Utils");
const todo_item_repository_1 = require("../DataAccess/todo-item-repository");
const httpTrigger = function (context, req) {
    return __awaiter(this, void 0, void 0, function* () {
        context.log.info('Edit todo item started.');
        const id = context.bindingData.id;
        const userId = (0, Utils_1.getUserId)();
        const todoItem = req.body;
        if (todoItem && todoItem.title && todoItem.description) {
            const todoItemRecord = {
                id: id,
                userId: userId,
                title: todoItem.title,
                description: todoItem.description
            };
            try {
                yield (0, todo_item_repository_1.editTodoItem)(id, userId, todoItemRecord);
                context.res = {
                    status: 200,
                    body: todoItemRecord
                };
            }
            catch (error) {
                if (error.message.includes("Entity with the specified id does not exist in the system")) {
                    context.res = {
                        status: 404
                    };
                }
                else {
                    throw error;
                }
            }
        }
        else {
            context.res = {
                status: 400
            };
        }
        context.log.info('Edit todo item completed.');
        context.done();
    });
};
exports.default = httpTrigger;
//# sourceMappingURL=index.js.map