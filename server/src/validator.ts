import { HttpStatus, HttpException } from '@nestjs/common';
export class Validator {
    errors: string[];

    constructor() {
        this.errors = [];
    }

    assertExists(name: string, element: any): void {
        if (element === undefined) {
            this.errors.push(`${name} must be given.`);
        }
    }

    assertLength(name: string, string: string, length: number): void {
        if (string === undefined || string.length < length) {
            this.errors.push(
                `${name} must be at least be ${length} characters long.`,
            );
        }
    }

    assertGreaterOrEqualTo(name: string, value: number, amount: number): void {
        if (value === undefined || value < amount) {
            this.errors.push(`${name} must be greater or equal to ${amount}.`);
        }
    }

    throwErrors(status: HttpStatus): void {
        Validator.throwErrors(this.errors, status);
    }

    static throwErrors(errors: string[], status: HttpStatus): void {
        if (errors.length > 0) {
            throw new HttpException(Validator.getErrorsString(errors), status);
        }
    }

    static throwNotFound() {
        this.throwErrors(
            ['No element with that ID found'],
            HttpStatus.NOT_FOUND,
        );
    }

    static getErrorsString(errors: string[]): string {
        return JSON.stringify({ errors: errors });
    }
}
