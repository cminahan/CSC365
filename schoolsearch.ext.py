# Lab 1  -- CSC 365  -- Claire Minahan
import os


def find_kid(name, students):
    for kid in students:
        if kid[0] == name:
            new_kid = kid[:4]
            new_kid.append(kid[6])
            new_kid.append(kid[7])
            print(",".join(new_kid))


def find_bus(name, students):
    for kid in students:
        if kid[0] == name:
            new_kid = kid[:2]
            new_kid.append(kid[4])
            print(",".join(new_kid))


def find_tgb(item, students, loc, num): #T=6, 2; G=2, 2; B=4, 4
    for kid in students:
        if kid[loc] == item:
            print(",".join(kid[:num]))


def find_high(grade, students):
    gpa = 0.0
    child = ["", "", "", "", "", ""]
    for kid in students:
        if kid[2] == grade and float(kid[5]) > gpa:
            gpa = float(kid[5])
            child[0] = kid[0]
            child[1] = kid[1]
            child[2] = kid[5]
            child[3] = kid[6]
            child[4] = kid[7]
            child[5] = kid[4]
    if child != ["", "", "", "", "", ""]:
        print(",".join(child))


def find_low(grade, students):
    gpa = 5.0
    child = ["", "", "", "", "", ""]
    for kid in students:
        if kid[2] == grade and float(kid[5]) < gpa:
            gpa = float(kid[5])
            child[0] = kid[0]
            child[1] = kid[1]
            child[2] = kid[5]
            child[3] = kid[6]
            child[4] = kid[7]
            child[5] = kid[4]
    if child != ["", "", "", "", "", ""]:
        print(",".join(child))


def find_average(grade, students):
    if grade < 0 or grade > 6:
        return
    gpa, count = 0.0, 0
    for kid in students:
        if int(kid[2]) == grade:
            count += 1
            gpa += float(kid[5])
    if count == 0:
        print(str(grade) + ": 0.00")
    else:
        print(str(grade) + ": " + str("{:.2f}".format(gpa/count)))


def find_info(students):
    grades = [0, 0, 0, 0, 0, 0, 0]
    for kid in students:
        grades[int(kid[2])] += 1
    for x in range(0, 7):
        print(str(x) + ":", grades[x])


def sort_inputs(input, students):
    if input[0] == "S:" or input[0] == "Student:":
        if len(input) == 2:
            find_kid(str(input[1]), students)
        elif input[2] == "B" or input[2] == "Bus":
            find_bus(str(input[1][:-1]), students)
    elif input[0] == "T:" or input[0] == "Teacher:":
        find_tgb(str(input[1]), students, 6, 2)
    elif input[0] == "G:" or input[0] == "Grade:":
        if len(input) == 2:
            find_tgb(str(input[1]), students, 2, 2)
        elif input[2] == "H" or input[2] == "High":
            find_high(str(input[1][0]), students)
        elif input[2] == "L" or input[2] == "Low":
            find_low(input[1][0], students)
    elif input[0] == "B:" or input[0] == "Bus:":
        find_tgb(str(input[1]), students, 4, 4)
    elif input[0] == "A:" or input[0] == "Average:":
        find_average(int(input[1]), students)
    elif input[0] == "I" or input[0] == "Info":
        find_info(students)
    print("")


def school_search(students):
    while True:
        user = input("Enter Command: ")
        if user == "Q" or user == "Quit":
            break
        sort_inputs(user.strip().split(" "), students)
    return


def main():
    students = []
    if not os.path.isfile("students.txt"):
        return
    with open("students.txt") as file:
        for arg in file.readlines():
            students.append(arg.strip().split(","))
    file.close()
    school_search(students)


if __name__ == "__main__":
    main()