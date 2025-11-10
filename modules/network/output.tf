output "public_subnet_id"{
    value = aws_subnet.public.id
}

output "private_subnet1_id"{
    value = aws_subnet.private1.id
}

output "private_subnet2_id"{
    value = aws_subnet.private2.id
}

output "private_security_group_id"{
    value = aws_security_group.private_sg.id
}

output "public_security_group_id"{
    value = aws_security_group.public_sg.id
}