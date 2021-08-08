import { HttpStatus, HttpException } from '@nestjs/common';
export class Validator {
    errors: string[];

    constructor() {
        this.errors = [];
    }

    assertExists(name: string, element: any): void {
        if (!element) {
            this.errors.push(`${name} must be given.`);
        }
    }

    assertLength(name: string, string: string, length: number): void {
        if (!string || string.length < length) {
            this.errors.push(
                `${name} must be at least be ${length} characters long.`,
            );
        }
    }

    assertGreaterThan(
        name: string,
        value: number,
        greaterThanAmount: number,
    ): void {
        if (!value || value <= greaterThanAmount) {
            this.errors.push(
                `${name} must be greater than ${greaterThanAmount}.`,
            );
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

    static getErrorsString(errors: string[]): string {
        return JSON.stringify({ errors: errors });
    }
}
